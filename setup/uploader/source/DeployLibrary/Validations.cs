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
    using System.Text.RegularExpressions;

    public static class Validations
    {
        private static string ippattern = @"^([1-9]|[1-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5])(\.([0-9]|[1-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5])){3}$";
        private static Regex checkip = new Regex(ippattern);
        private static string domainpattern = @"[a-zA-Z0-9_-]+(\.[a-zA-Z0-9_-]*)+";
        private static Regex checkdomain = new Regex(domainpattern);

        public static bool IsValidIPAddress(string ipaddress)
        {
            if (string.IsNullOrWhiteSpace(ipaddress))
            {
                return false;
            }

            return checkip.IsMatch(ipaddress, 0);
        }

        public static bool IsValidDomainName(string domainName)
        {
            if (string.IsNullOrWhiteSpace(domainName))
            {
                return false;
            }

            return checkdomain.IsMatch(domainName, 0);
        }
    }
}
