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

namespace Microsoft.Samples.AcceleratorsHttpModules
{
    using System;
    using System.IO;
    using System.Threading;
    using System.Web;

    public class PackageInstallationModule : IHttpModule
    {
        public void Init(HttpApplication app)
        {
            app.BeginRequest += this.OnBeginRequest;
        }

        public void Dispose()
        {
        }

        private void OnBeginRequest(object sender, EventArgs e)
        {
            int retryCount = 0;
            var request = ((HttpApplication)sender).Request;

            if (request.Url.AbsoluteUri.Contains("umbraco/developer/packages/installer.aspx"))
            {
                var directory = request.QueryString["dir"];
                if (!string.IsNullOrWhiteSpace(directory))
                {
                    var package = Path.Combine(directory, "package.xml");

                    while (!File.Exists(package))
                    {
                        if (retryCount > 5)
                        {
                            ((HttpApplication)sender).Context.Response.Redirect(request.Url.AbsoluteUri);
                        }

                        retryCount++;
                        Thread.Sleep(1000);
                    }
                }
            }
        }
    }
}
