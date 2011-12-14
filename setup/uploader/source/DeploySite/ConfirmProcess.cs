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

namespace DeploySite
{
    using System.Windows.Forms;

    public partial class ConfirmProcess : Form
    {
        public ConfirmProcess()
        {
            this.InitializeComponent();
        }

        public DialogResult Process(string storageAccount, string hostName)
        {
            this.Text = string.Format("Confirm upload for {0}", hostName);

            this.lblMessage.Text = string.Format("The web site {0} has already been deployed into Windows Azure Blob Storage for the storage account {1}.\r\n\r\nDo you wish to delete the existing Web Application and upload a new version, overwrite the individual files, or cancel the upload?", hostName, storageAccount);

            return this.ShowDialog();
        }
    }
}
