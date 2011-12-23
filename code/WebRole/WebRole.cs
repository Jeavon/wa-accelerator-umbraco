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
    
    using Microsoft.Web.Administration;
    using Microsoft.WindowsAzure;
    using Microsoft.WindowsAzure.ServiceRuntime;
    using Microsoft.WindowsAzure.StorageClient;

    using Microsoft.Samples.UmbracoAccelerator.Sites;
    using Microsoft.Samples.UmbracoAccelerator.Sync;
    

    public class WebRole : RoleEntryPoint
    {
        private const int SqlSessionCleanupIntervalMinutes = 5;

        private string localPath;
        private CloudBlobContainer container;
        private Dictionary<string, FileEntry> entries;
        private HashSet<string> mappings;
        private IEnumerable<string> directoriesToExclude;
        

        private SyncHelper _syncHelper;

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

            this.InitializeRole();
            
            this.Sync(); //start with full initial sync

            return base.OnStart();
        }

        private void InitializeRole()
        {
            if (!RoleEnvironment.IsEmulated)
            {
                ServerManager sm = new ServerManager();

                // Set the AppPool to "AlwaysRunning" so it starts on machine reboot
                // Disable Idle Time Process Shutdown - We want the AppPool to remain running
                // Disable AppPool recycling at regular intervals - We want the AppPool to remain running
                string appPoolName = sm.Sites[RoleEnvironment.CurrentRoleInstance.Id + "_Web"].Applications[0].ApplicationPoolName;
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

            if (RoleEnvironment.IsEmulated)
            {
                this.container = CloudStorageAccount.Parse("UseDevelopmentStorage=true").CreateCloudBlobClient().GetContainerReference(RoleEnvironment.GetConfigurationSettingValue("SitesContainerName"));
            }
            else
            {
                this.container = CloudStorageAccount.Parse(RoleEnvironment.GetConfigurationSettingValue("DataConnectionString")).CreateCloudBlobClient().GetContainerReference(RoleEnvironment.GetConfigurationSettingValue("SitesContainerName"));
            }
            this.container.CreateIfNotExist();

            this.entries = new Dictionary<string, FileEntry>();
            this.mappings = new HashSet<string>();

            this._syncHelper = new SyncHelper();
        }

        public void Sync()
        {
            this._syncHelper.Sync(this.localPath, this.container, this.directoriesToExclude);
        }

        public void SqlSessionCleanup()
        {
            string lastUpdatedTimestamp = DateTime.MinValue.ToString();

            //check for well-known blob and the timestamp contained within
            var syncBlob = this.container.GetBlobReference("_sync_");
            try
            {
                syncBlob.FetchAttributes();
            }
            catch (StorageClientException)
            {
                syncBlob.UploadText(DateTime.UtcNow.ToString());
            }

            lastUpdatedTimestamp = syncBlob.DownloadText();

            DateTime lastUpdated = DateTime.Parse(lastUpdatedTimestamp);

            if (DateTime.UtcNow > lastUpdated
                && (DateTime.UtcNow - lastUpdated) > TimeSpan.FromMinutes(SqlSessionCleanupIntervalMinutes))
            {
                //TODO

                syncBlob.UploadText(DateTime.UtcNow.ToString());
            }
        }

        public void SyncForever(TimeSpan interval)
        {
            while (true)
            {
                try
                {
                    this.Sync();
                    this.SqlSessionCleanup();
                }
                catch (Exception e)
                {
                    // log all exceptions to blobs
                    CloudBlobContainer errors = null;
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

                Thread.Sleep(interval);
            }
        }
    }
}