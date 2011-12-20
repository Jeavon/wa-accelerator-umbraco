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

namespace DeployLibrary
{
    using System;
    using System.Collections.Generic;
    using System.IO;
    using System.Linq;
    using System.Text;
    using Microsoft.WindowsAzure;
    using Microsoft.WindowsAzure.StorageClient;

    public class Uploader
    {
        private string hostName;
        private string pathToUpload;
        private string storageAccountName;
        private string storageAccountKey;
        private string containerName;

        public Uploader(string hostName, string pathToUpload, string storageAccountName, string storageAccountKey, string containerName)
        {
            this.hostName = hostName;
            this.pathToUpload = pathToUpload;
            this.storageAccountName = storageAccountName;
            this.storageAccountKey = storageAccountKey;
            this.containerName = containerName;
        }

        public delegate void MessageHandler(string message, long size);

        public delegate void DeleteBlobHandler(string message);

        public delegate void CountHandler(int count, long totalSize);

        public event CountHandler UploadCount;

        public event MessageHandler UploadFile;

        public event DeleteBlobHandler DeleteBlob;

        public event MessageHandler CreateDirectory;

        public bool Stopped { get; set; }

        public void Run()
        {
            CloudBlobContainer container = this.GetContainer();

            //CloudBlob hostBlob = container.GetBlobReference(this.hostName);
            //hostBlob.Metadata["IsDirectory"] = "true";
            //hostBlob.UploadByteArray(new byte[0]);

            var things = EnumerateEntries(this.pathToUpload);

            var totalLength = things.Sum(t => t.Item2.Length);
            var count = things.Count();

            if (this.UploadCount != null)
            {
                this.UploadCount(count, totalLength);
            }

            foreach (var thing in things)
            {
                if (this.Stopped)
                {
                    break;
                }

                var path = thing.Item1;
                var blobPath = string.Format("{0}/{1}", this.hostName, path);
                var entry = thing.Item2;
                var newBlob = container.GetBlobReference(blobPath);

                if (entry.IsDirectory)
                {
                    //if (this.CreateDirectory != null) 
                    //{
                    //    this.CreateDirectory(blobPath, 0);
                    //}
                    //newBlob.Metadata["IsDirectory"] = "true";
                    //newBlob.UploadByteArray(new byte[0]);
                }
                else
                {
                    if (this.UploadFile != null)
                    {
                        int pos = blobPath.IndexOf('/');
                        string name = blobPath;

                        if (pos > 0)
                            name = blobPath.Substring(pos + 1);

                        this.UploadFile(name, entry.Length);
                    }

                    newBlob.UploadFile(Path.Combine(this.pathToUpload, path));
                }
            }
        }

        public void Stop()
        {
            this.Stopped = true;
        }

        public ICollection<string> GetCurrentBlobs()
        {
            CloudBlobContainer container = this.GetContainer();
            int prefixLength = container.Uri.ToString().Length;
            IList<string> blobs = new List<string>();

            foreach (var blob in container.ListBlobs(new BlobRequestOptions { UseFlatBlobListing = true, BlobListingDetails = BlobListingDetails.Metadata }).OfType<CloudBlob>())
            {
                var path = blob.Uri.ToString().Substring(prefixLength + 1);

                if (path.Equals(this.hostName, StringComparison.OrdinalIgnoreCase) ||
                    path.StartsWith(this.hostName + "/", StringComparison.OrdinalIgnoreCase))
                {
                    blobs.Add(path);
                }
            }

            return blobs;
        }

        public void DeleteCurrentBlobs()
        {
            CloudBlobContainer container = this.GetContainer();

            foreach (string blobpath in this.GetCurrentBlobs())
            {
                if (this.DeleteBlob != null)
                {
                    this.DeleteBlob(blobpath);
                }

                CloudBlob blob = container.GetBlobReference(blobpath);
                blob.DeleteIfExists();
            }
        }

        public long GetTotalSizeToUpload()
        {
            var things = EnumerateEntries(this.pathToUpload);

            return things.Sum(t => t.Item2.Length);
        }

        private static IEnumerable<Tuple<string, Entry>> EnumerateEntries(string path)
        {
            foreach (var item in Directory.EnumerateFileSystemEntries(path, "*", SearchOption.AllDirectories))
            {
                var relativePath = item.Substring(path.Length + 1).Replace('\\', '/');
                var info = new FileInfo(item);
                var entry = new Entry
                {
                    LocalLastModified = info.LastWriteTimeUtc,
                    IsDirectory = info.Attributes.HasFlag(FileAttributes.Directory),
                    Length = info.Attributes.HasFlag(FileAttributes.Directory) ? 0 : info.Length
                };

                yield return new Tuple<string, Entry>(relativePath, entry);
            }
        }

        private CloudBlobContainer GetContainer()
        {
            CloudStorageAccount account;

            if (this.storageAccountKey == null)
            {
                account = CloudStorageAccount.DevelopmentStorageAccount;
            }
            else
            {
                string storageConnectionString = string.Format("DefaultEndpointsProtocol=https;AccountName={0};AccountKey={1}", this.storageAccountName, this.storageAccountKey);
                account = CloudStorageAccount.Parse(storageConnectionString);
            }

            CloudBlobContainer container = account.CreateCloudBlobClient().GetContainerReference(this.containerName);
            container.CreateIfNotExist();

            return container;
        }
    }
}

