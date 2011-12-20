// ----------------------------------------------------------------------------------
// Microsoft Developer & Platform Evangelism
// 
// Copyright (c) Microsoft Corporation. All rights reserved.
// 
// THIS CODE AND INFORMATION ARE PROVIDED "AS IS" WITHOUT WARRANTY OF ANY KIND, 
// EITHER EXPRESSED OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE IMPLIED WARRANTIES 
// OF MERCHANTABILITY AND/OR FITNESS FOR A PARTICULAR PURPOSE.
// ----------------------------------------------------------------------------------
// The example companies, organizations, products, domain names,
// e-mail addresses, logos, people, places, and events depicted
// herein are fictitious.  No association with any real company,
// organization, product, domain name, email address, logo, person,
// places, or events is intended or should be inferred.
// ----------------------------------------------------------------------------------

namespace Microsoft.Samples.UmbracoAccelerator
{
    using System;
    using System.Collections.Generic;
    using System.Globalization;
    using System.IO;
    using System.Linq;
    using System.Security.AccessControl;
    using System.Security.Cryptography.X509Certificates;
    using System.Text.RegularExpressions;
    using System.Threading;
    using System.Xml.Linq;
    using Microsoft.Samples.UmbracoAccelerator.Sites;
    using Microsoft.Web.Administration;
    using Microsoft.WindowsAzure;
    using Microsoft.WindowsAzure.ServiceRuntime;
    using Microsoft.WindowsAzure.StorageClient;
    

    public class Entry
    {
        public DateTime LocalLastModified { get; set; }

        public DateTime CloudLastModified { get; set; }

        public bool IsDirectory { get; set; }
    }

    public class WebRole : RoleEntryPoint
    {
        private string localPath;
        private CloudBlobContainer container;
        private Dictionary<string, Entry> entries;
        private HashSet<string> mappings;
        private IEnumerable<string> directoriesToExclude;

        private object syncLock = new object();

        public override void Run()
        {
            this.SyncForever(TimeSpan.FromSeconds(1));
        }

        public override bool OnStart()
        {
            RoleEnvironment.Changing += (_, e) =>
            {
                if (e.Changes.Any(c => c is RoleEnvironmentConfigurationSettingChange))
                {
                    e.Cancel = true;
                }
            };

            if (!RoleEnvironment.IsEmulated)
            {
                ServerManager sm = new ServerManager();
                
                // Set the AppPool to "AlwaysRunning" so it starts on machine reboot
                // Disable Idle Time Process Shutdown - We want the AppPool to remain running
                // Disable AppPool recycling at regular intervals - We want the AppPool to remain running
                string appPoolName = sm.Sites[RoleEnvironment.CurrentRoleInstance.Id+"_Web"].Applications[0].ApplicationPoolName;
                sm.ApplicationPools[appPoolName].AutoStart = true;
                sm.ApplicationPools[appPoolName].ProcessModel.IdleTimeout = TimeSpan.Zero;
                sm.ApplicationPools[appPoolName].Recycling.PeriodicRestart.Time = TimeSpan.Zero;

                sm.CommitChanges();
            }

            this.localPath = RoleEnvironment.GetLocalResource("Sites").RootPath.TrimEnd('\\');
            this.directoriesToExclude = RoleEnvironment.GetConfigurationSettingValue("DirectoriesToExclude").Split(';');

            var sec = Directory.GetAccessControl(this.localPath);
            sec.AddAccessRule(new FileSystemAccessRule("Everyone", FileSystemRights.FullControl, InheritanceFlags.ContainerInherit | InheritanceFlags.ObjectInherit, PropagationFlags.None, AccessControlType.Allow));
            Directory.SetAccessControl(this.localPath, sec);

            string localdata = RoleEnvironment.GetLocalResource("LocalData").RootPath.TrimEnd('\\');

            var secdata = Directory.GetAccessControl(localdata);
            secdata.AddAccessRule(new FileSystemAccessRule("Everyone", FileSystemRights.FullControl, InheritanceFlags.ContainerInherit | InheritanceFlags.ObjectInherit, PropagationFlags.None, AccessControlType.Allow));
            Directory.SetAccessControl(localdata, secdata);

            this.container = CloudStorageAccount.Parse(RoleEnvironment.GetConfigurationSettingValue("DataConnectionString")).CreateCloudBlobClient().GetContainerReference(RoleEnvironment.GetConfigurationSettingValue("SitesContainerName"));
            this.container.CreateIfNotExist();
            this.entries = new Dictionary<string, Entry>();
            this.mappings = new HashSet<string>();

            this.Sync();

            return base.OnStart();
        }

        public void Sync()
        {
            // avoid concurrent updates
            if (Monitor.TryEnter(syncLock))
            {
                try
                {
                    HashSet<string> umbracoSettings = new HashSet<string>();
                    HashSet<string> seen = new HashSet<string>();
                    HashSet<string> newCerts = new HashSet<string>();

                    //Sync local sites -> blob storage (initially no local entries exist)
                    foreach (var thing in this.EnumerateLocalEntries())
                    {
                        var path = thing.Item1;
                        var entry = thing.Item2;

                        seen.Add(path);
                        if (Path.GetFileName(path).ToLowerInvariant() == "umbracosettings.config")
                        {
                            umbracoSettings.Add(path);
                        }

                        if (!this.entries.ContainsKey(path) || this.entries[path].LocalLastModified < entry.LocalLastModified)
                        {
                            var newBlob = this.container.GetBlobReference(path);
                            if (entry.IsDirectory)
                            {
                                //newBlob.Metadata["IsDirectory"] = "true";
                                //newBlob.UploadByteArray(new byte[0]);
                            }
                            else if (Path.GetFileName(path).ToLowerInvariant() != "umbraco.config")
                            {
                                // ignore umbraco.config
                                using (var stream = File.Open(Path.Combine(this.localPath, path), FileMode.Open, FileAccess.Read, FileShare.ReadWrite | FileShare.Delete))
                                {
                                    newBlob.UploadFromStream(stream);
                                }
                            }

                            entry.CloudLastModified = newBlob.Properties.LastModifiedUtc;
                            this.entries[path] = entry;
                        }
                    }

                    //Delete blob entries that are not seen locally (local system is master)
                    foreach (var path in this.entries.Keys.Where(k => !seen.Contains(k)).ToArray())
                    {
                        if (string.IsNullOrEmpty(Path.GetDirectoryName(path)) && Path.GetExtension(path).ToLowerInvariant() == ".pfx")
                        {
                            // leave these alone
                            continue;
                        }

                        try
                        {
                            this.container.GetBlobReference(path).Delete();
                        }
                        catch
                        {
                            // ignore if the blob's already gone
                        }

                        this.entries.Remove(path);
                    }

                    //Time to check on blob storge for updates to sync
                    seen = new HashSet<string>();

                    foreach (var blob in this.container.ListBlobs(new BlobRequestOptions { UseFlatBlobListing = true, BlobListingDetails = BlobListingDetails.Metadata }).OfType<CloudBlob>())
                    {
                        var path = blob.Uri.ToString().Substring(this.container.Uri.ToString().Length + 1);
                        var entry = new Entry { IsDirectory = blob.Metadata["IsDirectory"] == "true", CloudLastModified = blob.Properties.LastModifiedUtc };

                        seen.Add(path);

                        if (!this.entries.ContainsKey(path) || this.entries[path].CloudLastModified < entry.CloudLastModified)
                        {
                            if (entry.IsDirectory)
                            {
                                Directory.CreateDirectory(Path.Combine(this.localPath, path));
                            }
                            else if (string.IsNullOrEmpty(Path.GetDirectoryName(path)) && Path.GetExtension(path).ToLowerInvariant() == ".pfx")
                            {
                                newCerts.Add(Path.GetFileNameWithoutExtension(path).ToLowerInvariant());

                                // don't actually download this, no need to have the cert sitting around on disk
                                this.entries[path] = entry;
                            }
                            else
                            {
                                // ignore umbraco.config
                                if (Path.GetFileName(path).ToLowerInvariant() != "umbraco.config")
                                {
                                    Directory.CreateDirectory(Path.Combine(this.localPath, Path.GetDirectoryName(path)));

                                    using (var stream = File.Open(Path.Combine(this.localPath, path), FileMode.Create, FileAccess.Write, FileShare.ReadWrite | FileShare.Delete))
                                    {
                                        blob.DownloadToStream(stream);
                                    }
                                }
                            }

                            entry.LocalLastModified = new FileInfo(Path.Combine(this.localPath, path)).LastWriteTimeUtc;
                            this.entries[path] = entry;
                        }
                    }
                    //delete entries locally that are not represented in blob storage
                    foreach (var path in this.entries.Keys.Where(k => !seen.Contains(k) && Path.GetFileName(k).ToLowerInvariant() != "umbraco.config").ToArray())
                    {
                        if (this.entries[path].IsDirectory)
                        {
                            Directory.Delete(Path.Combine(this.localPath, path), true);
                        }
                        else
                        {
                            if (string.IsNullOrEmpty(Path.GetDirectoryName(path)) && Path.GetExtension(path).ToLowerInvariant() == ".pfx")
                            {
                                newCerts.Add(Path.GetFileNameWithoutExtension(path).ToLowerInvariant());
                            }

                            try
                            {
                                File.Delete(Path.Combine(this.localPath, path));
                            }
                            catch
                            {
                            }
                        }

                        this.entries.Remove(path);
                    }

                    //done syncing... additional configuration and setup below

                    var newMappings = new HashSet<string>();
                    foreach (var site in Directory.EnumerateDirectories(this.localPath).Select(d => Path.GetFileName(d).ToLowerInvariant()))
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
                    }

                    if (!newMappings.SetEquals(this.mappings))
                    {
                        var hostsFile = Environment.ExpandEnvironmentVariables(@"%windir%\system32\drivers\etc\hosts");
                        File.Delete(hostsFile);
                        File.WriteAllLines(hostsFile, newMappings);
                        this.mappings = newMappings;
                    }

                    foreach (var path in umbracoSettings)
                    {
                        try
                        {
                            var siteName = path.Split('/').First();
                            var fileName = Path.Combine(this.localPath, path);
                            var doc = XDocument.Load(fileName);
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
                                    servers.Add(new XElement("server", new XText(address)));
                                }

                                doc.Save(fileName);
                            }
                        }
                        catch
                        {
                            // likely because the file no longer exists (this happens if one gets deleted)... no big deal no matter what the error is
                        }
                    }

                    this.UpdateSites(newCerts);
                } //end sync try {} block

                finally { Monitor.Exit(syncLock); }
            }
            else
            {
                //skip sync
            }
        }

        public void SyncForever(TimeSpan interval)
        {
            while (true)
            {
                try
                {
                    this.Sync();
                }
                catch (Exception e)
                {
                    // log all exceptions to blobs
                    var errors = CloudStorageAccount.Parse(RoleEnvironment.GetConfigurationSettingValue("DataConnectionString")).CreateCloudBlobClient().GetContainerReference("errors");
                    errors.CreateIfNotExist();
                    var error = errors.GetBlobReference((DateTime.MaxValue - DateTime.UtcNow).Ticks.ToString("d19") + ".txt");
                    error.Properties.ContentType = "text/plain";
                    error.UploadText(e.ToString());
                }

                Thread.Sleep(interval);
            }
        }

        private IEnumerable<Tuple<string, Entry>> EnumerateLocalEntries()
        {
            foreach (var directory in Directory.EnumerateFileSystemEntries(this.localPath, "*", SearchOption.AllDirectories))
            {
                var relativePath = directory.Substring(this.localPath.Length + 1).Replace('\\', '/');
                var info = new FileInfo(directory);
                var entry = new Entry
                {
                    LocalLastModified = info.LastWriteTimeUtc,
                    IsDirectory = info.Attributes.HasFlag(FileAttributes.Directory)
                };

                if (IsExcluded(relativePath))
                    continue;

                if (entry.IsDirectory)
                    continue;

                yield return new Tuple<string, Entry>(relativePath, entry);
            }
        }

        private bool IsExcluded(string topPath)
        {
            int position = topPath.IndexOf('/');

            if (position <= 0)
                return false;

            // Remove Site name
            string path = topPath.Substring(position + 1);

            if (this.directoriesToExclude.Contains(path, StringComparer.OrdinalIgnoreCase))
                return true;

            foreach (string toexclude in this.directoriesToExclude)
                if (path.StartsWith(toexclude + "/"))
                    return true;

            return false;
        }

        private void UpdateSites(IEnumerable<string> newCerts)
        {
            var sitesToAdd = new Dictionary<string, string>();

            foreach (var hostToAdd in Directory.EnumerateDirectories(this.localPath).Select(d => Path.GetFileName(d).ToLowerInvariant()))
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
                        Path.Combine(this.localPath, site.Value));

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
                        var rawData = this.container.GetBlobReference(site.Value + ".pfx").DownloadByteArray();
                        var password = this.container.GetBlobReference(site.Value + ".pfx.txt").DownloadText();

                        cert = new X509Certificate2(rawData, password);
                    }
                    catch
                    {
                        // ignore if blob is missing or invalid
                    }

                    if (cert != null)
                    {
                        var store = new X509Store(StoreName.My, StoreLocation.LocalMachine);
                        store.Open(OpenFlags.ReadWrite);
                        store.Add(cert);
                        newSite.Bindings.Add(RoleEnvironment.CurrentRoleInstance.InstanceEndpoints["HttpsIn"].IPEndpoint.ToString() + ":" + site.Value, cert.GetCertHash(), StoreName.My.ToString());
                    }
                }

                try
                {
                    serverManager.CommitChanges();
                }
                catch
                {
                }
            }
        }

        private void SaveSites(string[] sites)
        {
            string path = RoleEnvironment.GetLocalResource("LocalData").RootPath.TrimEnd('\\');
            Directory.CreateDirectory(path);
            string filename = Path.Combine(path, "Sites.txt");

            Dictionary<string, SiteInfo> infosites = new Dictionary<string, SiteInfo>();

            foreach (var key in this.entries.Keys)
            {
                var entry = this.entries[key];
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
                string[] oldsites = File.ReadAllLines(filename);

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

            File.WriteAllLines(filename, newsites);
        }
    }
}