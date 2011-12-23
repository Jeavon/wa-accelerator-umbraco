using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Microsoft.WindowsAzure.StorageClient;
using Microsoft.WindowsAzure.ServiceRuntime;
using Microsoft.Web.Administration;
using System.IO;
using System.Security.AccessControl;
using Microsoft.WindowsAzure;
using System.Threading;
using System.Globalization;
using System.Text.RegularExpressions;
using System.Xml.Linq;
using System.Security.Cryptography.X509Certificates;
using Microsoft.Samples.UmbracoAccelerator.Sites;

namespace Microsoft.Samples.UmbracoAccelerator.Sync
{
    public class SyncHelper
    {
        private string _localPath;
        private CloudBlobContainer _container;
        private Dictionary<string, FileEntry> _entries = new Dictionary<string,FileEntry>();
        private HashSet<string> _mappings = new HashSet<string>();
        private IEnumerable<string> _directoriesToExclude;

        private object _syncLock = new object();


        public void Sync(string localPath, CloudBlobContainer blobContainer, IEnumerable<string> directoriesToExclude)
        {
            this._localPath = localPath;
            this._container = blobContainer;
            this._directoriesToExclude = directoriesToExclude;

            if (Monitor.TryEnter(this._syncLock)) // avoid concurrent updates from starting on this instance
            {
                try
                {
                    HashSet<string> umbracoSettings = new HashSet<string>();
                    HashSet<string> seen = new HashSet<string>();
                    HashSet<string> newCerts = new HashSet<string>();

                    this.SyncLocalToBlob(seen, umbracoSettings);

                    //Time to check on blob storge for updates to sync
                    seen = new HashSet<string>();
                    this.SyncBlobToLocal(seen, newCerts);

                    this.UpdateInstanceHostsFile();

                    this.UpdateUmbracoSettings(umbracoSettings);

                    this.UpdateSites(newCerts);
                } //end sync try {} block

                finally { Monitor.Exit(this._syncLock); }
            }
            else
            {
                //skip sync
            }
        }

        private void SyncLocalToBlob(HashSet<string> seen, HashSet<string> umbracoSettings)
        {
            //Sync local sites -> blob storage
            foreach (var thing in this.EnumerateLocalEntries())
            {
                var path = thing.Item1;
                var entry = thing.Item2;

                seen.Add(path);
                if (Path.GetFileName(path).ToLowerInvariant() == "umbracosettings.config")
                {
                    umbracoSettings.Add(path);
                }

                if (!this._entries.ContainsKey(path) || this._entries[path].LocalLastModified < entry.LocalLastModified)
                {
                    var newBlob = this._container.GetBlobReference(path);
                    if (entry.IsDirectory)
                    {
                        //newBlob.Metadata["IsDirectory"] = "true";
                        //newBlob.UploadByteArray(new byte[0]);
                    }
                    else if (Path.GetFileName(path).ToLowerInvariant() != "umbraco.config") // ignore umbraco.config
                    {
                        TryFiveTimes(() =>
                        {
                            using (var stream = File.Open(Path.Combine(this._localPath, path), FileMode.Open, FileAccess.Read, FileShare.ReadWrite | FileShare.Delete))
                            {
                                newBlob.UploadFromStream(stream);
                            }
                        });
                    }

                    entry.CloudLastModified = newBlob.Properties.LastModifiedUtc;
                    this._entries[path] = entry;
                }
            }

            //Delete blob entries that are not seen locally (local system is master)
            foreach (var path in this._entries.Keys.Where(k => !seen.Contains(k)).ToArray())
            {
                if (string.IsNullOrEmpty(Path.GetDirectoryName(path)) && Path.GetExtension(path).ToLowerInvariant() == ".pfx")
                {
                    // leave these alone
                    continue;
                }

                try
                {
                    TryFiveTimes(() =>
                        {
                            this._container.GetBlobReference(path).Delete();
                        });
                }
                catch
                {
                    // ignore if the blob's already gone
                }

                this._entries.Remove(path);
            }
        }

        private void SyncBlobToLocal(HashSet<string> seen, HashSet<string> newCerts)
        {
            foreach (var blob in this._container.ListBlobs(new BlobRequestOptions { UseFlatBlobListing = true, BlobListingDetails = BlobListingDetails.Metadata }).OfType<CloudBlob>())
            {
                var path = blob.Uri.ToString().Substring(this._container.Uri.ToString().Length + 1);
                var entry = new FileEntry { IsDirectory = blob.Metadata["IsDirectory"] == "true", CloudLastModified = blob.Properties.LastModifiedUtc };

                seen.Add(path);

                if (!this._entries.ContainsKey(path) || this._entries[path].CloudLastModified < entry.CloudLastModified)
                {
                    if (entry.IsDirectory)
                    {
                        TryFiveTimes(() =>
                            {
                                Directory.CreateDirectory(Path.Combine(this._localPath, path));
                            });
                    }
                    else if (string.IsNullOrEmpty(Path.GetDirectoryName(path)) && Path.GetExtension(path).ToLowerInvariant() == ".pfx")
                    {
                        newCerts.Add(Path.GetFileNameWithoutExtension(path).ToLowerInvariant());

                        // don't actually download this, no need to have the cert sitting around on disk
                        this._entries[path] = entry;
                    }
                    else
                    {
                        if (Path.GetFileName(path).ToLowerInvariant() != "umbraco.config") // ignore umbraco.config
                        {
                            TryFiveTimes(() =>
                                {
                                    Directory.CreateDirectory(Path.Combine(this._localPath, Path.GetDirectoryName(path)));
                                });

                            TryFiveTimes(() =>
                                {
                                    using (var stream = File.Open(Path.Combine(this._localPath, path), FileMode.Create, FileAccess.Write, FileShare.ReadWrite | FileShare.Delete))
                                    {
                                        blob.DownloadToStream(stream);
                                    }
                                });
                        }
                    }

                    TryFiveTimes(() =>
                        {
                            entry.LocalLastModified = new FileInfo(Path.Combine(this._localPath, path)).LastWriteTimeUtc;
                        });
                    this._entries[path] = entry;
                }
            }

            //delete local entries that are not represented in blob storage
            foreach (var path in this._entries.Keys.Where(k => !seen.Contains(k) && Path.GetFileName(k).ToLowerInvariant() != "umbraco.config").ToArray())
            {
                if (this._entries[path].IsDirectory)
                {
                    TryFiveTimes(() =>
                        {
                            Directory.Delete(Path.Combine(this._localPath, path), true);
                        });
                }
                else
                {
                    if (string.IsNullOrEmpty(Path.GetDirectoryName(path)) && Path.GetExtension(path).ToLowerInvariant() == ".pfx")
                    {
                        newCerts.Add(Path.GetFileNameWithoutExtension(path).ToLowerInvariant());
                    }

                    try
                    {
                        TryFiveTimes(() =>
                            {
                                File.Delete(Path.Combine(this._localPath, path));
                            });
                    }
                    catch
                    {
                    }
                }
                this._entries.Remove(path);
            }
        }

        private void UpdateInstanceHostsFile()
        {
            var newMappings = new HashSet<string>();
            var hostsFile = Environment.ExpandEnvironmentVariables(@"%windir%\system32\drivers\etc\hosts");

            foreach (var site in Directory.EnumerateDirectories(this._localPath).Select(d => Path.GetFileName(d).ToLowerInvariant()))
            {
                foreach (var instance in RoleEnvironment.CurrentRoleInstance.Role.Instances)
                {
                    newMappings.Add(string.Format(
                        CultureInfo.InvariantCulture,
                        "{0} {1}.{2}",
                        instance.InstanceEndpoints["UnusedInternal"].IPEndpoint.Address,
                        Regex.Match(instance.Id, @"\d+$").Value,
                        site));
                }

                if (RoleEnvironment.IsEmulated)
                {
                    //make site accessible through emulated load balancer IP (will still have to use deployed port though)
                    newMappings.Add("127.0.0.1 " + site);
                }
            }
            if (!newMappings.SetEquals(this._mappings))
            {
                if (RoleEnvironment.IsEmulated)
                {
                    //don't obliterate hosts file if running in emulator
                    TryFiveTimes(() =>
                        {
                            File.Copy(hostsFile, hostsFile + "." + Guid.NewGuid().ToString());
                        });
                }
                TryFiveTimes(() =>
                    {
                        File.Delete(hostsFile);
                    });
                TryFiveTimes(() =>
                    {
                        File.WriteAllLines(hostsFile, newMappings);
                    });
                
                this._mappings = newMappings;
            }
        }

        private void UpdateUmbracoSettings(HashSet<string> umbracoSettings)
        {
            foreach (var path in umbracoSettings)
            {
                try
                {
                    var siteName = path.Split('/').First();
                    var fileName = Path.Combine(this._localPath, path);
                    XDocument doc = null;
                    TryFiveTimes(() =>
                        {
                            doc = XDocument.Load(fileName);
                        });
                    var dc = doc.Root.Element("distributedCall");
                    dc.Attribute("enable").Value = "true";
                    var servers = dc.Element("servers");
                    var oldServers = new HashSet<string>(servers.Elements("server").Select(e => e.Value));
                    var newServers = new HashSet<string>(RoleEnvironment.CurrentRoleInstance.Role.Instances.Select(i => Regex.Match(i.Id, @"\d+$").Value + "." + siteName));

                    if (!oldServers.SetEquals(newServers))
                    {
                        servers.RemoveAll();
                        foreach (var address in newServers)
                        {
                            //server DNS name (now including port)
                            servers.Add(new XElement("server", new XText(address + ":" + RoleEnvironment.CurrentRoleInstance.InstanceEndpoints["HttpIn"].IPEndpoint.Port.ToString())));
                        }

                        TryFiveTimes(() =>
                            {
                                doc.Save(fileName);
                            });
                    }
                }
                catch
                {
                    // likely because the file no longer exists (this happens if one gets deleted)... no big deal no matter what the error is
                }
            }
        }

        private IEnumerable<Tuple<string, FileEntry>> EnumerateLocalEntries()
        {
            foreach (var directory in Directory.EnumerateFileSystemEntries(this._localPath, "*", SearchOption.AllDirectories))
            {
                var relativePath = directory.Substring(this._localPath.Length + 1).Replace('\\', '/');
                var info = new FileInfo(directory);
                var entry = new FileEntry
                {
                    LocalLastModified = info.LastWriteTimeUtc,
                    IsDirectory = info.Attributes.HasFlag(FileAttributes.Directory)
                };

                if (IsExcluded(relativePath))
                    continue;

                if (entry.IsDirectory)
                    continue;

                yield return new Tuple<string, FileEntry>(relativePath, entry);
            }
        }

        private bool IsExcluded(string topPath)
        {
            int position = topPath.IndexOf('/');

            if (position <= 0)
                return false;

            // Remove Site name
            string path = topPath.Substring(position + 1);

            if (this._directoriesToExclude.Contains(path, StringComparer.OrdinalIgnoreCase))
                return true;

            foreach (string toexclude in this._directoriesToExclude)
                if (path.StartsWith(toexclude + "/"))
                    return true;

            return false;
        }

        private void UpdateSites(IEnumerable<string> newCerts)
        {
            var sitesToAdd = new Dictionary<string, string>();

            foreach (var hostToAdd in Directory.EnumerateDirectories(this._localPath).Select(d => Path.GetFileName(d).ToLowerInvariant()))
            {
                sitesToAdd[hostToAdd.Replace('.', '-')] = hostToAdd;
            }

            using (var serverManager = new ServerManager())
            {
                foreach (var newCert in newCerts)
                {
                    // remove each of these so we reprocess them with an SSL binding
                    try
                    {
                        var s = serverManager.Sites[RoleEnvironment.CurrentRoleInstance.Id + "_" + newCert.Replace('.', '-')];
                        serverManager.Sites.Remove(s);

                        var appPoolName = s.Name;
                        var appPool = serverManager.ApplicationPools.SingleOrDefault(ap => ap.Name.Equals(appPoolName, StringComparison.OrdinalIgnoreCase));
                        if (appPool != null)
                        {
                            serverManager.ApplicationPools.Remove(appPool);
                        }
                    }
                    catch
                    {
                        // ignore if the site doesn't exist
                    }
                }

                List<string> sitestosave = new List<string>();

                foreach (var site in serverManager.Sites.Where(s => s.Name.StartsWith(RoleEnvironment.CurrentRoleInstance.Id, StringComparison.OrdinalIgnoreCase)).ToArray())
                {
                    var name = site.Name.Substring(RoleEnvironment.CurrentRoleInstance.Id.Length + 1).ToLowerInvariant();

                    // never delete "Web," which is the website for this web role
                    if (!sitesToAdd.Remove(name) && name != "web")
                    {
                        serverManager.Sites.Remove(site);

                        // Remove appPool
                        var appPoolName = site.Name;
                        var appPool = serverManager.ApplicationPools.SingleOrDefault(ap => ap.Name.Equals(appPoolName, StringComparison.OrdinalIgnoreCase));
                        if (appPool != null)
                        {
                            serverManager.ApplicationPools.Remove(appPool);
                        }
                    }
                    else
                    {
                        sitestosave.Add(name.Replace('-', '.'));
                    }
                }

                this.SaveSites(sitestosave.ToArray());

                foreach (var site in sitesToAdd)
                {
                    // default binding is just the site name (example.org)
                    var newSite = serverManager.Sites.Add(
                        RoleEnvironment.CurrentRoleInstance.Id + "_" + site.Key,
                        "http",
                        RoleEnvironment.CurrentRoleInstance.InstanceEndpoints["HttpIn"].IPEndpoint.ToString() + ":" + site.Value,
                        Path.Combine(this._localPath, site.Value));

                    // Create application pool
                    var appPoolName = newSite.Name;
                    var appPool = serverManager.ApplicationPools.SingleOrDefault(ap => ap.Name.Equals(appPoolName, StringComparison.OrdinalIgnoreCase));
                    if (appPool == null)
                    {
                        appPool = serverManager.ApplicationPools.Add(appPoolName);
                        appPool.ManagedRuntimeVersion = "v4.0";
                        appPool.ProcessModel.IdentityType = ProcessModelIdentityType.NetworkService;
                    }

                    newSite.ApplicationDefaults.ApplicationPoolName = appPool.Name;

                    // second binding is (n.example.org), where n is the number in the instance ID
                    var n = Regex.Match(RoleEnvironment.CurrentRoleInstance.Id, @"\d+$").Value;
                    newSite.Bindings.Add(RoleEnvironment.CurrentRoleInstance.InstanceEndpoints["HttpIn"].IPEndpoint.ToString() + ":" + n + "." + site.Value, "http");

                    // third binding is SSL (if applicable)
                    X509Certificate2 cert = null;
                    try
                    {
                        TryFiveTimes(() =>
                            {
                                var rawData = this._container.GetBlobReference(site.Value + ".pfx").DownloadByteArray();
                                var password = this._container.GetBlobReference(site.Value + ".pfx.txt").DownloadText();

                                cert = new X509Certificate2(rawData, password);
                            });
                    }
                    catch
                    {
                        // ignore if blob is missing or invalid
                    }

                    if (cert != null)
                    {
                        TryFiveTimes(() =>
                            {
                                var store = new X509Store(StoreName.My, StoreLocation.LocalMachine);
                                store.Open(OpenFlags.ReadWrite);
                                store.Add(cert);
                                newSite.Bindings.Add(RoleEnvironment.CurrentRoleInstance.InstanceEndpoints["HttpsIn"].IPEndpoint.ToString() + ":" + site.Value, cert.GetCertHash(), StoreName.My.ToString());
                            });
                    }
                }

                try
                {
                    TryFiveTimes(() =>
                        {
                            serverManager.CommitChanges();
                        });
                }
                catch
                {
                }
            }
        }

        private void SaveSites(string[] sites)
        {
            string path = RoleEnvironment.GetLocalResource("LocalData").RootPath.TrimEnd('\\');
            TryFiveTimes(() =>
                {
                    Directory.CreateDirectory(path);
                });
            string filename = Path.Combine(path, "Sites.txt");

            Dictionary<string, SiteInfo> infosites = new Dictionary<string, SiteInfo>();
            foreach (var key in this._entries.Keys)
            {
                var entry = this._entries[key];
                string domain;

                int pos = key.IndexOf('/');

                if (pos > 0)
                    domain = key.Substring(0, key.IndexOf('/'));
                else
                    domain = key;

                if (sites.Contains(domain))
                {
                    if (!infosites.ContainsKey(domain))
                    {
                        infosites[domain] = new SiteInfo() { Name = domain, LastCloudDateTime = entry.CloudLastModified, NoFiles = 1 };
                    }
                    else
                    {
                        infosites[domain].NoFiles++;
                        if (infosites[domain].LastCloudDateTime < entry.CloudLastModified)
                            infosites[domain].LastCloudDateTime = entry.CloudLastModified;
                    }
                }
            }

            string[] newsites = new string[infosites.Keys.Count];
            int nsite = 0;

            foreach (var info in infosites.Values)
                newsites[nsite++] = string.Format("{0}|{1}|{2}", info.Name, info.LastCloudDateTime, info.NoFiles);

            if (File.Exists(filename))
            {
                string[] oldsites = null;
                TryFiveTimes(() =>
                {
                    oldsites = File.ReadAllLines(filename);
                });

                if (oldsites.Length == newsites.Length)
                {
                    int k;
                    for (k = 0; k < oldsites.Length; k++)
                        if (oldsites[k] != newsites[k])
                            break;

                    if (k >= oldsites.Length)
                        return;
                }
            }

            TryFiveTimes(() =>
                {
                    File.WriteAllLines(filename, newsites);
                });
        }

        private static void TryFiveTimes(Action action)
        {
            for (int i = 0; ; i++)
            {
                try
                {
                    action();
                    return;
                }
                catch (Exception)
                {
                    if (i >= 5)
                    {
                        throw;
                    }
                }
            }
        }
    }
}