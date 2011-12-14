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
    using System;
    using System.Collections.Generic;
    using System.IO;
    using System.Windows.Forms;
    using DeployLibrary;

    public partial class UploadForm : Form
    {
        private const int DeleteWeight = 1024;
        private const string DefaultContainer = "sites";

        private DeployConfigurationManager confmanager = new DeployConfigurationManager();
        private DeployConfiguration configuration;
        private Uploader uploader;
        private long totalsize = 0;
        private int blobstodelete = 0;
        private int scale = 1;
        private Dictionary<Control, bool> errorEnabled = new Dictionary<Control, bool>();
        private string containerName;

        public UploadForm()
            : this(string.Empty, string.Empty, string.Empty, string.Empty, string.Empty)
        {

        }

        public UploadForm(string folderName, string containerName, string hostName, string storageAccountName, string storageAccountKey)
        {
            this.InitializeComponent();
            this.SetupDefaultValues(folderName, containerName, hostName, storageAccountName, storageAccountKey);
            this.SetupErrorProvider();
            this.LoadConfiguration();
            this.CheckIsValid();
            this.SetupToolTips();
        }

        public string ContainerName 
        {
            get
            {
                return string.IsNullOrWhiteSpace(this.containerName) ? DefaultContainer : this.containerName;
            }
            set
            {
                this.containerName = value;
            }
        }

        private static bool IsEmpty(TextBox text)
        {
            return string.IsNullOrWhiteSpace(text.Text);
        }

        private static bool IsEmpty(ComboBox combo)
        {
            return string.IsNullOrWhiteSpace(combo.Text);
        }

        private void SetupDefaultValues(string folderName, string containerName, string hostName, string storageAccountName, string storageAccountKey)
        {
            this.ContainerName = containerName;

            this.cmbHostName.Text = hostName;
            this.txtPathToUpload.Text = folderName.EndsWith("\\") ? folderName.Substring(0, folderName.Length - 1) : folderName;
            this.txtStorageAccountName.Text = storageAccountName.ToLowerInvariant();
            this.txtStorageAccountKey.Text = storageAccountKey;
        }

        private void SetupToolTips()
        {
            this.toolTip1 = new ToolTip(this.components);
            this.toolTip1.SetToolTip(this.cmbHostName, "The name of the site, which will be used to configure the host header in IIS.");
            this.toolTip1.SetToolTip(this.txtPathToUpload, "The path were the website you want to upload is located.");
            this.toolTip1.SetToolTip(this.txtStorageAccountName, "The name of the storage account that will be used for uploading the site.");
            this.toolTip1.SetToolTip(this.txtStorageAccountKey, "The primary or secondary keys used to access the storage account where the site will be uploaded.");
            this.toolTip1.SetToolTip(this.chkUpdateHostsFile, "Check if you want to edit the hosts file for resolving your site's address.");
            this.toolTip1.SetToolTip(this.txtIPAddress, "The IP address of your deployment. You can get it from http://windows.azure.com.");
        }

        private void LoadConfiguration()
        {
            this.configuration = this.confmanager.GetConfiguration();

            if (this.configuration != null && this.configuration.Parameters != null)
            {
                this.cmbHostName.Items.Clear();

                foreach (var parameter in this.configuration.Parameters)
                {
                    this.cmbHostName.Items.Add(parameter.HostName);
                }
            }
        }

        private void SetupErrorProvider()
        {
            this.errorProvider1.BlinkStyle = ErrorBlinkStyle.NeverBlink;
            this.SetupErrorProviderInControl(this.cmbHostName);
            this.SetupErrorProviderInControl(this.btnSelectFolder);
            this.SetupErrorProviderInControl(this.txtStorageAccountName);
            this.SetupErrorProviderInControl(this.txtStorageAccountKey);
            this.SetupErrorProviderInControl(this.txtIPAddress);
        }

        private void SetupErrorProviderInControl(Control control)
        {
            this.errorProvider1.SetIconPadding(control, 5);
            this.errorProvider1.SetIconAlignment(control, ErrorIconAlignment.MiddleRight);
            this.errorEnabled[control] = false;
        }

        private void CancelButtonClick(object sender, EventArgs e)
        {
            this.Close();
        }

        private void UploadButtonClick(object sender, EventArgs e)
        {
            try
            {
                this.UploadProcess();
            }
            catch (Exception ex)
            {
                this.uploader.Stop();
                this.uploader = null;
                MessageBox.Show(ex.Message, "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                this.ToDialog();
            }
        }

        private void UploadProcess()
        {
            string hostName = this.cmbHostName.Text;
            string pathToUpload = this.txtPathToUpload.Text;
            string storageAccountName = this.txtStorageAccountName.Text.ToLowerInvariant();
            string storageAccountKey = this.txtStorageAccountKey.Text;
            string containerName = this.ContainerName;
            bool useDevelopmentStore = this.chkUseDevelopmentStorage.Checked;
            bool updateHostsFiles = this.chkUpdateHostsFile.Checked;
            string ipaddress = this.txtIPAddress.Text;

            this.uploader = new Uploader(
                hostName,
                pathToUpload,
                useDevelopmentStore ? null : storageAccountName,
                useDevelopmentStore ? null : storageAccountKey,
                containerName);

            this.uploader.UploadFile += this.UploadingFile;
            this.uploader.DeleteBlob += this.DeletingBlob;

            this.ToProcess();

            ICollection<string> blobs = this.uploader.GetCurrentBlobs();
            this.blobstodelete = blobs.Count;
            this.totalsize = this.uploader.GetTotalSizeToUpload();
            this.PrepareProgressBar();

            if (blobs.Count > 0)
            {
                ConfirmProcess confirm = new ConfirmProcess();
                DialogResult result = confirm.Process(useDevelopmentStore ? "DevStorage" : storageAccountName, hostName);

                if (result == DialogResult.Cancel)
                {
                    this.ToDialog();
                    return;
                }

                if (result == DialogResult.Retry)
                {
                    this.lblStatus.Text = "Deleting existing blobs";
                    this.uploader.DeleteCurrentBlobs();
                }
            }

            this.uploader.Run();

            if (this.uploader.Stopped)
            {
                MessageBox.Show("Site Upload Stopped", "Upload Process");
            }
            else
            {
                if (updateHostsFiles)
                {
                    HostsUpdater.UpdateDomain(hostName, ipaddress);
                }

                this.prgProcess.Value = this.prgProcess.Maximum;
                this.prgProcess.Refresh();
                MessageBox.Show("Site Upload Completed", "Upload Process");

                DeployParameters parameters = new DeployParameters()
                {
                    HostName = hostName,
                    PathToUpload = pathToUpload,
                    UseDevelopmentStorage = useDevelopmentStore,
                    StorageAccountName = storageAccountName,
                    StorageAccountKey = storageAccountKey,
                    UpdateHostsFile = updateHostsFiles,
                    IPAddress = ipaddress
                };

                this.confmanager.SaveDeployParameters(this.configuration, parameters);
                this.LoadConfiguration();
            }

            this.SetupErrorProvider();
            this.ToDialog();
            this.uploader = null;
        }

        private void ToProcess()
        {
            this.cmbHostName.Enabled = false;
            this.txtPathToUpload.Enabled = false;
            this.txtStorageAccountName.Enabled = false;
            this.txtStorageAccountKey.Enabled = false;
            this.chkUseDevelopmentStorage.Enabled = false;
            this.chkUpdateHostsFile.Enabled = false;
            this.txtIPAddress.Enabled = false;
            this.btnUpload.Visible = false;
            this.btnCancel.Visible = false;
            this.prgProcess.Value = 0;
            this.prgProcess.Visible = true;
            this.btnSelectFolder.Enabled = false;
            this.lblStatus.Text = string.Empty;
            this.lblStatus.Visible = true;
            this.btnStop.Top = this.btnCancel.Top;
            this.btnStop.Left = this.btnCancel.Left;
            this.btnStop.Visible = true;
            this.Refresh();
        }

        private void ToDialog()
        {
            this.cmbHostName.Enabled = true;
            this.txtPathToUpload.Enabled = true;
            this.chkUseDevelopmentStorage.Enabled = true;

            if (this.chkUseDevelopmentStorage.Checked)
            {
                this.txtStorageAccountName.Enabled = false;
                this.txtStorageAccountKey.Enabled = false;
            }
            else
            {
                this.txtStorageAccountName.Enabled = true;
                this.txtStorageAccountKey.Enabled = true;
            }

            if (this.chkUpdateHostsFile.Checked)
            {
                this.txtIPAddress.Enabled = true;
            }
            else
            {
                this.txtIPAddress.Enabled = false;
            }

            this.chkUpdateHostsFile.Enabled = true;
            this.btnSelectFolder.Enabled = true;
            this.prgProcess.Visible = false;
            this.btnStop.Visible = false;
            this.lblStatus.Visible = false;
            this.btnUpload.Visible = true;
            this.btnCancel.Visible = true;

            this.Refresh();
        }

        private void SelectFolderButtonClick(object sender, EventArgs e)
        {
            if (this.folderToUploadDialog.ShowDialog() != DialogResult.OK)
            {
                return;
            }

            this.txtPathToUpload.Text = this.folderToUploadDialog.SelectedPath;
            this.errorEnabled[this.txtPathToUpload] = true;
            this.CheckIsValid();
        }

        private void PrepareProgressBar()
        {
            this.prgProcess.Value = 0;

            this.scale = 1;

            long size = this.totalsize;

            while (size > int.MaxValue)
            {
                this.scale *= 1024;
                size /= 1024;
            }

            this.prgProcess.Maximum = (int)size + this.blobstodelete * DeleteWeight;
        }

        private void DeletingBlob(string message)
        {
            this.lblStatus.Text = string.Format("Deleting blob: {0}", message);
            this.lblStatus.Refresh();

            if (this.prgProcess.Value < this.prgProcess.Maximum)
            {
                this.prgProcess.Value += DeleteWeight;
                this.prgProcess.Refresh();
            }
        }

        private void UploadingFile(string message, long size)
        {
            this.lblStatus.Text = string.Format("Uploading blob: {0}", message);
            this.lblStatus.Refresh();

            int update = (int)(size / this.scale);

            if (this.prgProcess.Value + update < this.prgProcess.Maximum)
            {
                this.prgProcess.Value += update;
            }
            else
            {
                this.prgProcess.Value = this.prgProcess.Maximum;
            }

            this.prgProcess.Update();

            Application.DoEvents();
        }

        private void UseDevelopmentStorageCheckedChanged(object sender, EventArgs e)
        {
            if (this.chkUseDevelopmentStorage.Checked)
            {
                this.txtStorageAccountName.Enabled = false;
                this.txtStorageAccountKey.Enabled = false;
            }
            else
            {
                this.txtStorageAccountName.Enabled = true;
                this.txtStorageAccountKey.Enabled = true;
            }

            this.errorEnabled[this.txtStorageAccountName] = false;
            this.errorEnabled[this.txtStorageAccountKey] = false;

            this.CheckIsValid();
        }

        private void StopButtonClick(object sender, EventArgs e)
        {
            if (this.uploader != null)
            {
                this.uploader.Stop();
            }
        }

        private bool IsValid()
        {
            bool isValid = true;

            if (IsEmpty(this.cmbHostName))
            {
                this.SetError(this.cmbHostName, "Host name cannot be blank");
                isValid = false;
            }
            else if (!Validations.IsValidDomainName(this.cmbHostName.Text))
            {
                this.SetError(this.cmbHostName, "Host name is not valid");
                isValid = false;
            }
            else
            {
                this.SetError(this.cmbHostName, string.Empty);
            }

            if (IsEmpty(this.txtPathToUpload))
            {
                this.SetError(this.btnSelectFolder, "Path cannot be blank");
                isValid = false;
            }
            else if (!Directory.Exists(this.txtPathToUpload.Text))
            {
                this.SetError(this.btnSelectFolder, "Path doesn't exist");
                isValid = false;
            }
            else
            {
                this.SetError(this.btnSelectFolder, string.Empty);
            }

            if (!this.chkUseDevelopmentStorage.Checked)
            {
                if (IsEmpty(this.txtStorageAccountName))
                {
                    this.SetError(this.txtStorageAccountName, "Storage Account Name cannot be blank");
                    isValid = false;
                }
                else
                {
                    this.SetError(this.txtStorageAccountName, string.Empty);
                }

                if (IsEmpty(this.txtStorageAccountKey))
                {
                    this.SetError(this.txtStorageAccountKey, "Storage Account Key cannot be blank");
                    isValid = false;
                }
                else
                {
                    this.SetError(this.txtStorageAccountKey, string.Empty);
                }
            }
            else
            {
                this.SetError(this.txtStorageAccountName, string.Empty);
                this.SetError(this.txtStorageAccountKey, string.Empty);
            }

            if (this.chkUpdateHostsFile.Checked)
            {
                if (IsEmpty(this.txtIPAddress))
                {
                    this.SetError(this.txtIPAddress, "IP Address cannot be blank");
                    isValid = false;
                }
                else if (!Validations.IsValidIPAddress(this.txtIPAddress.Text))
                {
                    this.SetError(this.txtIPAddress, "Invalid IP Address");
                    isValid = false;
                }
                else
                {
                    this.SetError(this.txtIPAddress, string.Empty);
                }
            }
            else
            {
                this.SetError(this.txtIPAddress, string.Empty);
            }

            return isValid;
        }

        private void CheckIsValid()
        {
            this.btnUpload.Enabled = this.IsValid();
        }

        private void PathToUploadTextChanged(object sender, EventArgs e)
        {
            this.CheckIsValid();
        }

        private void StorageAccountNameTextChanged(object sender, EventArgs e)
        {
            this.CheckIsValid();
        }

        private void StorageAccountKeyTextChanged(object sender, EventArgs e)
        {
            this.CheckIsValid();
        }

        private void UpdateHostsFileCheckedChanged(object sender, EventArgs e)
        {
            if (this.chkUpdateHostsFile.Checked)
            {
                this.txtIPAddress.Enabled = true;
            }
            else
            {
                this.txtIPAddress.Enabled = false;
            }

            this.CheckIsValid();
        }

        private void SetError(Control control, string message)
        {
            if (this.errorEnabled.ContainsKey(control) && this.errorEnabled[control])
            {
                this.errorProvider1.SetError(control, message);
            }
            else
            {
                this.errorProvider1.SetError(control, string.Empty);
            }
        }

        private void PathToUploadLeave(object sender, EventArgs e)
        {
            this.CheckIsValid();
        }

        private void StorageAccountNameLeave(object sender, EventArgs e)
        {
            this.errorEnabled[this.txtStorageAccountKey] = true;
            this.CheckIsValid();
        }

        private void StorageAccountKeyLeave(object sender, EventArgs e)
        {
            this.errorEnabled[this.txtStorageAccountName] = true;
            this.CheckIsValid();
        }

        private void IPAddressLeave(object sender, EventArgs e)
        {
            this.errorEnabled[this.txtIPAddress] = true;
            this.CheckIsValid();
        }

        private void SelectFolderLeave(object sender, EventArgs e)
        {
            this.errorEnabled[this.btnSelectFolder] = true;
            this.CheckIsValid();
        }

        private void IPAddressTextChanged(object sender, EventArgs e)
        {
            this.CheckIsValid();
        }

        private void HostNameSelectedIndexChanged(object sender, EventArgs e)
        {
            string hostName = (string)this.cmbHostName.Text;

            if (!string.IsNullOrWhiteSpace(hostName))
            {
                var parameters = this.confmanager.GetDeployParametersByHostName(this.configuration, hostName);

                if (parameters != null)
                {
                    this.txtPathToUpload.Text = parameters.PathToUpload;
                    this.chkUseDevelopmentStorage.Checked = parameters.UseDevelopmentStorage;
                    this.txtStorageAccountName.Text = parameters.StorageAccountName.ToLowerInvariant();
                    this.txtStorageAccountKey.Text = parameters.StorageAccountKey;
                    this.chkUpdateHostsFile.Checked = parameters.UpdateHostsFile;
                    this.txtIPAddress.Text = parameters.IPAddress;

                    this.ToDialog();
                }
            }
        }

        private void HostNameLeave(object sender, EventArgs e)
        {
            this.errorEnabled[this.cmbHostName] = true;
            this.CheckIsValid();
        }

        private void HostNameTextChanged(object sender, EventArgs e)
        {
            this.CheckIsValid();
        }
    }
}

