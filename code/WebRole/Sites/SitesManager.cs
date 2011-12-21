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

using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.IO;
using Microsoft.Web.Administration;
using Microsoft.WindowsAzure.ServiceRuntime;
using Microsoft.WindowsAzure;
using Microsoft.WindowsAzure.StorageClient;

namespace Microsoft.Samples.UmbracoAccelerator.Sites
{
    public class SitesManager
    {
        private string localPath;

        public SitesManager(string localPath)
        {
            this.localPath = localPath;
        }

        public IEnumerable<SiteInfo> GetSitesInformation()
        {
            List<SiteInfo> sites = new List<SiteInfo>();

            try
            {
                string path = RoleEnvironment.GetLocalResource("LocalData").RootPath.TrimEnd('\\');
                string filename = Path.Combine(path, "Sites.txt");
                string[] serversites = File.ReadAllLines(filename);

                foreach (var serversite in serversites)
                {
                    var site = sites.Where(s => s.Name.Equals(serversite, StringComparison.OrdinalIgnoreCase)).FirstOrDefault();
                    if (site != null)
                        site.IsWebSite = true;
                }

                foreach (var serversite in serversites)
                {
                    string[] data = serversite.Split('|');
                    sites.Add(new SiteInfo() { Name = data[0], LastCloudDateTime = DateTime.Parse(data[1]), NoFiles = int.Parse(data[2]) });
                }
            }
            catch (Exception e)
            {
                CloudBlobContainer errors;
                if (RoleEnvironment.IsEmulated)
                {
                    errors = CloudStorageAccount.Parse("UseDevelopmentStorage=true").CreateCloudBlobClient().GetContainerReference("errors");
                }
                else
                {
                    errors = CloudStorageAccount.Parse(RoleEnvironment.GetConfigurationSettingValue("DataConnectionString")).CreateCloudBlobClient().GetContainerReference("errors");
                }
                //var errors = CloudStorageAccount.Parse(RoleEnvironment.GetConfigurationSettingValue("DataConnectionString")).CreateCloudBlobClient().GetContainerReference("errors");
                errors.CreateIfNotExist();
                var error = errors.GetBlobReference((DateTime.MaxValue - DateTime.UtcNow).Ticks.ToString("d19") + ".txt");
                error.Properties.ContentType = "text/plain";
                error.UploadText(e.ToString());
            }

            return sites;
        }

        private IEnumerable<FileInfo> EnumerateFiles(string path)
        {
            foreach (var item in Directory.EnumerateFileSystemEntries(path, "*", SearchOption.AllDirectories))
            {
                var relativePath = item.Substring(this.localPath.Length + 1).Replace('\\', '/');
                var info = new FileInfo(item);

                yield return info;
            }
        }
    }
}