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
    partial class UploadForm
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.TextBox txtPathToUpload;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.TextBox txtStorageAccountName;
        private System.Windows.Forms.Label label3;
        private System.Windows.Forms.TextBox txtStorageAccountKey;
        private System.Windows.Forms.Label label4;
        private System.Windows.Forms.CheckBox chkUpdateHostsFile;
        private System.Windows.Forms.Button btnUpload;
        private System.Windows.Forms.Button btnCancel;
        private System.Windows.Forms.Button btnSelectFolder;
        private System.Windows.Forms.FolderBrowserDialog folderToUploadDialog;
        private System.Windows.Forms.Label lblStatus;
        private System.Windows.Forms.ProgressBar prgProcess;
        private System.Windows.Forms.CheckBox chkUseDevelopmentStorage;
        private System.Windows.Forms.Button btnStop;
        private System.Windows.Forms.TextBox txtIPAddress;
        private System.Windows.Forms.Label label5;
        private System.Windows.Forms.ErrorProvider errorProvider1;
        private System.Windows.Forms.Panel panel1;
        private System.Windows.Forms.PictureBox pictureBox1;
        private System.Windows.Forms.ComboBox cmbHostName;
        private System.Windows.Forms.ToolTip toolTip1;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (this.components != null))
            {
                this.components.Dispose();
            }

            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.components = new System.ComponentModel.Container();
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(UploadForm));
            this.label1 = new System.Windows.Forms.Label();
            this.txtPathToUpload = new System.Windows.Forms.TextBox();
            this.label2 = new System.Windows.Forms.Label();
            this.txtStorageAccountName = new System.Windows.Forms.TextBox();
            this.label3 = new System.Windows.Forms.Label();
            this.txtStorageAccountKey = new System.Windows.Forms.TextBox();
            this.label4 = new System.Windows.Forms.Label();
            this.chkUpdateHostsFile = new System.Windows.Forms.CheckBox();
            this.btnUpload = new System.Windows.Forms.Button();
            this.btnCancel = new System.Windows.Forms.Button();
            this.btnSelectFolder = new System.Windows.Forms.Button();
            this.folderToUploadDialog = new System.Windows.Forms.FolderBrowserDialog();
            this.lblStatus = new System.Windows.Forms.Label();
            this.prgProcess = new System.Windows.Forms.ProgressBar();
            this.chkUseDevelopmentStorage = new System.Windows.Forms.CheckBox();
            this.btnStop = new System.Windows.Forms.Button();
            this.txtIPAddress = new System.Windows.Forms.TextBox();
            this.label5 = new System.Windows.Forms.Label();
            this.errorProvider1 = new System.Windows.Forms.ErrorProvider(this.components);
            this.panel1 = new System.Windows.Forms.Panel();
            this.pictureBox1 = new System.Windows.Forms.PictureBox();
            this.cmbHostName = new System.Windows.Forms.ComboBox();
            this.toolTip1 = new System.Windows.Forms.ToolTip(this.components);
            ((System.ComponentModel.ISupportInitialize)(this.errorProvider1)).BeginInit();
            this.panel1.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.pictureBox1)).BeginInit();
            this.SuspendLayout();
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Font = new System.Drawing.Font("Tahoma", 9.5F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label1.Location = new System.Drawing.Point(14, 31);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(234, 16);
            this.label1.TabIndex = 0;
            this.label1.Text = "Domain Name (e.g. www.contoso.com)";
            // 
            // txtPathToUpload
            // 
            this.txtPathToUpload.Font = new System.Drawing.Font("Tahoma", 9.5F);
            this.txtPathToUpload.Location = new System.Drawing.Point(17, 132);
            this.txtPathToUpload.Margin = new System.Windows.Forms.Padding(3, 4, 3, 4);
            this.txtPathToUpload.Name = "txtPathToUpload";
            this.txtPathToUpload.Size = new System.Drawing.Size(629, 23);
            this.txtPathToUpload.TabIndex = 3;
            this.txtPathToUpload.TextChanged += new System.EventHandler(this.PathToUploadTextChanged);
            this.txtPathToUpload.Leave += new System.EventHandler(this.PathToUploadLeave);
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Font = new System.Drawing.Font("Tahoma", 9.25F);
            this.label2.Location = new System.Drawing.Point(14, 101);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(109, 16);
            this.label2.TabIndex = 2;
            this.label2.Text = "Content to Deploy";
            // 
            // txtStorageAccountName
            // 
            this.txtStorageAccountName.Font = new System.Drawing.Font("Tahoma", 9.5F);
            this.txtStorageAccountName.Location = new System.Drawing.Point(17, 203);
            this.txtStorageAccountName.Margin = new System.Windows.Forms.Padding(3, 4, 3, 4);
            this.txtStorageAccountName.Name = "txtStorageAccountName";
            this.txtStorageAccountName.Size = new System.Drawing.Size(270, 23);
            this.txtStorageAccountName.TabIndex = 5;
            this.txtStorageAccountName.TextChanged += new System.EventHandler(this.StorageAccountNameTextChanged);
            this.txtStorageAccountName.Leave += new System.EventHandler(this.StorageAccountNameLeave);
            // 
            // label3
            // 
            this.label3.AutoSize = true;
            this.label3.Font = new System.Drawing.Font("Tahoma", 9.25F);
            this.label3.Location = new System.Drawing.Point(14, 172);
            this.label3.Name = "label3";
            this.label3.Size = new System.Drawing.Size(139, 16);
            this.label3.TabIndex = 4;
            this.label3.Text = "Storage Account Name";
            // 
            // txtStorageAccountKey
            // 
            this.txtStorageAccountKey.Font = new System.Drawing.Font("Tahoma", 9.5F);
            this.txtStorageAccountKey.Location = new System.Drawing.Point(17, 273);
            this.txtStorageAccountKey.Margin = new System.Windows.Forms.Padding(3, 4, 3, 4);
            this.txtStorageAccountKey.Name = "txtStorageAccountKey";
            this.txtStorageAccountKey.Size = new System.Drawing.Size(665, 23);
            this.txtStorageAccountKey.TabIndex = 7;
            this.txtStorageAccountKey.TextChanged += new System.EventHandler(this.StorageAccountKeyTextChanged);
            this.txtStorageAccountKey.Leave += new System.EventHandler(this.StorageAccountKeyLeave);
            // 
            // label4
            // 
            this.label4.AutoSize = true;
            this.label4.Font = new System.Drawing.Font("Tahoma", 9.25F);
            this.label4.Location = new System.Drawing.Point(14, 242);
            this.label4.Name = "label4";
            this.label4.Size = new System.Drawing.Size(126, 16);
            this.label4.TabIndex = 6;
            this.label4.Text = "Storage Account Key";
            // 
            // chkUpdateHostsFile
            // 
            this.chkUpdateHostsFile.AutoSize = true;
            this.chkUpdateHostsFile.Font = new System.Drawing.Font("Tahoma", 9.25F);
            this.chkUpdateHostsFile.Location = new System.Drawing.Point(17, 320);
            this.chkUpdateHostsFile.Margin = new System.Windows.Forms.Padding(3, 4, 3, 4);
            this.chkUpdateHostsFile.Name = "chkUpdateHostsFile";
            this.chkUpdateHostsFile.Size = new System.Drawing.Size(561, 20);
            this.chkUpdateHostsFile.TabIndex = 8;
            this.chkUpdateHostsFile.Text = "Update the Hosts File on your local machine for testing purposes (You must be Adm" +
    "inistrator)";
            this.chkUpdateHostsFile.UseVisualStyleBackColor = true;
            this.chkUpdateHostsFile.CheckedChanged += new System.EventHandler(this.UpdateHostsFileCheckedChanged);
            // 
            // btnUpload
            // 
            this.btnUpload.Font = new System.Drawing.Font("Tahoma", 9.25F);
            this.btnUpload.Location = new System.Drawing.Point(450, 36);
            this.btnUpload.Margin = new System.Windows.Forms.Padding(3, 4, 3, 4);
            this.btnUpload.Name = "btnUpload";
            this.btnUpload.Size = new System.Drawing.Size(121, 28);
            this.btnUpload.TabIndex = 9;
            this.btnUpload.Text = "Upload";
            this.btnUpload.UseVisualStyleBackColor = true;
            this.btnUpload.Click += new System.EventHandler(this.UploadButtonClick);
            // 
            // btnCancel
            // 
            this.btnCancel.DialogResult = System.Windows.Forms.DialogResult.Cancel;
            this.btnCancel.Font = new System.Drawing.Font("Tahoma", 9.25F);
            this.btnCancel.Location = new System.Drawing.Point(579, 36);
            this.btnCancel.Margin = new System.Windows.Forms.Padding(3, 4, 3, 4);
            this.btnCancel.Name = "btnCancel";
            this.btnCancel.Size = new System.Drawing.Size(121, 28);
            this.btnCancel.TabIndex = 10;
            this.btnCancel.Text = "Cancel";
            this.btnCancel.UseVisualStyleBackColor = true;
            this.btnCancel.Click += new System.EventHandler(this.CancelButtonClick);
            // 
            // btnSelectFolder
            // 
            this.btnSelectFolder.Location = new System.Drawing.Point(652, 131);
            this.btnSelectFolder.Margin = new System.Windows.Forms.Padding(3, 4, 3, 4);
            this.btnSelectFolder.Name = "btnSelectFolder";
            this.btnSelectFolder.Size = new System.Drawing.Size(30, 25);
            this.btnSelectFolder.TabIndex = 4;
            this.btnSelectFolder.Text = "...";
            this.btnSelectFolder.UseVisualStyleBackColor = true;
            this.btnSelectFolder.Click += new System.EventHandler(this.SelectFolderButtonClick);
            this.btnSelectFolder.Leave += new System.EventHandler(this.SelectFolderLeave);
            // 
            // lblStatus
            // 
            this.lblStatus.AutoSize = true;
            this.lblStatus.BackColor = System.Drawing.Color.Transparent;
            this.lblStatus.Location = new System.Drawing.Point(14, 12);
            this.lblStatus.Name = "lblStatus";
            this.lblStatus.Size = new System.Drawing.Size(0, 16);
            this.lblStatus.TabIndex = 11;
            this.lblStatus.Visible = false;
            // 
            // prgProcess
            // 
            this.prgProcess.Location = new System.Drawing.Point(14, 36);
            this.prgProcess.Margin = new System.Windows.Forms.Padding(3, 4, 3, 4);
            this.prgProcess.Name = "prgProcess";
            this.prgProcess.Size = new System.Drawing.Size(558, 28);
            this.prgProcess.TabIndex = 12;
            this.prgProcess.Visible = false;
            // 
            // chkUseDevelopmentStorage
            // 
            this.chkUseDevelopmentStorage.AutoSize = true;
            this.chkUseDevelopmentStorage.Font = new System.Drawing.Font("Tahoma", 9.25F);
            this.chkUseDevelopmentStorage.Location = new System.Drawing.Point(188, 172);
            this.chkUseDevelopmentStorage.Margin = new System.Windows.Forms.Padding(3, 4, 3, 4);
            this.chkUseDevelopmentStorage.Name = "chkUseDevelopmentStorage";
            this.chkUseDevelopmentStorage.Size = new System.Drawing.Size(175, 20);
            this.chkUseDevelopmentStorage.TabIndex = 5;
            this.chkUseDevelopmentStorage.Text = "Use Development Storage";
            this.chkUseDevelopmentStorage.UseVisualStyleBackColor = true;
            this.chkUseDevelopmentStorage.CheckedChanged += new System.EventHandler(this.UseDevelopmentStorageCheckedChanged);
            // 
            // btnStop
            // 
            this.btnStop.DialogResult = System.Windows.Forms.DialogResult.Cancel;
            this.btnStop.Font = new System.Drawing.Font("Tahoma", 9.25F);
            this.btnStop.Location = new System.Drawing.Point(577, 0);
            this.btnStop.Margin = new System.Windows.Forms.Padding(3, 4, 3, 4);
            this.btnStop.Name = "btnStop";
            this.btnStop.Size = new System.Drawing.Size(121, 28);
            this.btnStop.TabIndex = 13;
            this.btnStop.Text = "Stop";
            this.btnStop.UseVisualStyleBackColor = true;
            this.btnStop.Visible = false;
            this.btnStop.Click += new System.EventHandler(this.StopButtonClick);
            // 
            // txtIPAddress
            // 
            this.txtIPAddress.Enabled = false;
            this.txtIPAddress.Font = new System.Drawing.Font("Tahoma", 9.5F);
            this.txtIPAddress.Location = new System.Drawing.Point(98, 348);
            this.txtIPAddress.Margin = new System.Windows.Forms.Padding(3, 4, 3, 4);
            this.txtIPAddress.Name = "txtIPAddress";
            this.txtIPAddress.Size = new System.Drawing.Size(209, 23);
            this.txtIPAddress.TabIndex = 10;
            this.txtIPAddress.TextChanged += new System.EventHandler(this.IPAddressTextChanged);
            this.txtIPAddress.Leave += new System.EventHandler(this.IPAddressLeave);
            // 
            // label5
            // 
            this.label5.AutoSize = true;
            this.label5.Font = new System.Drawing.Font("Tahoma", 9.25F);
            this.label5.Location = new System.Drawing.Point(14, 352);
            this.label5.Name = "label5";
            this.label5.Size = new System.Drawing.Size(69, 16);
            this.label5.TabIndex = 9;
            this.label5.Text = "IP Address";
            // 
            // errorProvider1
            // 
            this.errorProvider1.ContainerControl = this;
            // 
            // panel1
            // 
            this.panel1.BackColor = System.Drawing.SystemColors.Window;
            this.panel1.BackgroundImage = ((System.Drawing.Image)(resources.GetObject("panel1.BackgroundImage")));
            this.panel1.BackgroundImageLayout = System.Windows.Forms.ImageLayout.Stretch;
            this.panel1.Controls.Add(this.pictureBox1);
            this.panel1.Controls.Add(this.btnStop);
            this.panel1.Controls.Add(this.prgProcess);
            this.panel1.Controls.Add(this.btnUpload);
            this.panel1.Controls.Add(this.btnCancel);
            this.panel1.Controls.Add(this.lblStatus);
            this.panel1.Dock = System.Windows.Forms.DockStyle.Bottom;
            this.panel1.Location = new System.Drawing.Point(0, 397);
            this.panel1.Margin = new System.Windows.Forms.Padding(3, 4, 3, 4);
            this.panel1.Name = "panel1";
            this.panel1.Size = new System.Drawing.Size(710, 73);
            this.panel1.TabIndex = 14;
            // 
            // pictureBox1
            // 
            this.pictureBox1.BackColor = System.Drawing.SystemColors.ScrollBar;
            this.pictureBox1.Dock = System.Windows.Forms.DockStyle.Top;
            this.pictureBox1.Location = new System.Drawing.Point(0, 0);
            this.pictureBox1.Margin = new System.Windows.Forms.Padding(3, 4, 3, 4);
            this.pictureBox1.Name = "pictureBox1";
            this.pictureBox1.Size = new System.Drawing.Size(710, 1);
            this.pictureBox1.TabIndex = 0;
            this.pictureBox1.TabStop = false;
            // 
            // cmbHostName
            // 
            this.cmbHostName.AutoCompleteMode = System.Windows.Forms.AutoCompleteMode.Suggest;
            this.cmbHostName.FormattingEnabled = true;
            this.cmbHostName.Location = new System.Drawing.Point(17, 54);
            this.cmbHostName.Name = "cmbHostName";
            this.cmbHostName.Size = new System.Drawing.Size(270, 24);
            this.cmbHostName.TabIndex = 1;
            this.cmbHostName.SelectedIndexChanged += new System.EventHandler(this.HostNameSelectedIndexChanged);
            this.cmbHostName.TextChanged += new System.EventHandler(this.HostNameTextChanged);
            this.cmbHostName.Leave += new System.EventHandler(this.HostNameLeave);
            // 
            // UploadForm
            // 
            this.AcceptButton = this.btnUpload;
            this.AutoScaleDimensions = new System.Drawing.SizeF(7F, 16F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(241)))), ((int)(((byte)(242)))), ((int)(((byte)(244)))));
            this.CancelButton = this.btnCancel;
            this.ClientSize = new System.Drawing.Size(710, 470);
            this.Controls.Add(this.cmbHostName);
            this.Controls.Add(this.panel1);
            this.Controls.Add(this.label5);
            this.Controls.Add(this.txtIPAddress);
            this.Controls.Add(this.chkUseDevelopmentStorage);
            this.Controls.Add(this.btnSelectFolder);
            this.Controls.Add(this.chkUpdateHostsFile);
            this.Controls.Add(this.txtStorageAccountKey);
            this.Controls.Add(this.label4);
            this.Controls.Add(this.txtStorageAccountName);
            this.Controls.Add(this.label3);
            this.Controls.Add(this.txtPathToUpload);
            this.Controls.Add(this.label2);
            this.Controls.Add(this.label1);
            this.Font = new System.Drawing.Font("Tahoma", 9.5F);
            this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedSingle;
            this.Icon = ((System.Drawing.Icon)(resources.GetObject("$this.Icon")));
            this.Margin = new System.Windows.Forms.Padding(3, 4, 3, 4);
            this.MaximizeBox = false;
            this.MinimizeBox = false;
            this.Name = "UploadForm";
            this.Text = "Deploy Web Site to Windows Azure Blob Storage";
            ((System.ComponentModel.ISupportInitialize)(this.errorProvider1)).EndInit();
            this.panel1.ResumeLayout(false);
            this.panel1.PerformLayout();
            ((System.ComponentModel.ISupportInitialize)(this.pictureBox1)).EndInit();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion
    }
}

