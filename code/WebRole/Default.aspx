<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="Microsoft.Samples.UmbracoAccelerator.Default" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="Content/Style/site.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <form id="form1" runat="server">
    <h1>
        Windows Azure Accelerator for Umbraco</h1>
    <p>
       The Windows Azure Accelerator for Umbraco is designed to enable Umbraco applications to be easily run on Windows Azure. The accelerator has been designed to enable you to rapidly deploy Umbraco applications and updates to your application without redeploying a full Windows Azure Service Package.  For more information about the accelerator, please visit the CodePlex site located <a href="http://go.microsoft.com/fwlink/?LinkId=215164">here</a>.
    </p>
    <h2>
        Available Sites
    </h2>
    <p>
    The following web sites have been dynamically created from Windows Azure Blob Storage.
    </p>
    <asp:GridView ID="grdSites" runat="server" AutoGenerateColumns="False" CellPadding="4"
        GridLines="None">
        <AlternatingRowStyle CssClass="odd" />
        <Columns>
            <asp:BoundField DataField="Name" HeaderText="Domain Name" HeaderStyle-CssClass="firstcol"
                ItemStyle-CssClass="firstcol" />
            <asp:BoundField DataField="LastCloudDateTime" HeaderText="Last Updated" HeaderStyle-CssClass="time"
                ItemStyle-CssClass="time" />
            <asp:BoundField DataField="NoFiles" HeaderText="# of Files" HeaderStyle-CssClass="count"
                ItemStyle-CssClass="count" />
        </Columns>
    </asp:GridView>
    <div id="footer">
        <div style="float:left;width:520px;">
            <img class="style1" src="Content/Images/windows-azure-platform-headline-2.png" />
        </div>
        <div style="float:left;width:150px;">
            <img class="style2" src="Content/Images/umbracoSplash.png" />
        </div>
        <div class="clear"></div>
    </div>
    </form>
</body>
</html>
