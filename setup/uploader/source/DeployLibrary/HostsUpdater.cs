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
    using System.IO;
    using System.Linq;

    public static class HostsUpdater
    {
        public static void UpdateDomain(string domainName, string ipaddress)
        {
            string path = Environment.GetFolderPath(Environment.SpecialFolder.System);
            string filename = Path.Combine(path, "Drivers/etc/hosts");
            string[] lines = File.ReadLines(filename).ToArray();
            bool found = false;
            string newline = string.Format("{0} {1}", ipaddress, domainName);

            for (int k = 0; k < lines.Length; k++)
            {
                string line = lines[k].Trim();
                if (line.StartsWith("#"))
                {
                    continue;
                }

                if (line.Contains(domainName))
                {
                    lines[k] = newline;
                    found = true;
                    break;
                }
            }

            if (found)
            {
                File.WriteAllLines(filename, lines);
            }
            else
            {
                File.AppendAllLines(filename, new string[] { newline });
            }
        }
    }
}
