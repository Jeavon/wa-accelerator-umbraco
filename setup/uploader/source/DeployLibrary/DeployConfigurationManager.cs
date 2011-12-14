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
    using System.Xml.Serialization;

    public class DeployConfigurationManager
    {
        private static XmlSerializer serializer = new XmlSerializer(typeof(DeployConfiguration));

        public DeployConfiguration GetConfiguration()
        {
            string filename = this.GetFileName();

            if (!File.Exists(filename))
            {
                return null;
            }

            try
            {
                using (var stream = new FileStream(filename, FileMode.Open))
                {
                    return (DeployConfiguration)serializer.Deserialize(stream);
                }
            }
            catch
            {
                return null;
            }
        }

        public void SaveConfiguration(DeployConfiguration configuration)
        {
            string filename = this.GetFileName();

            using (var stream = new FileStream(filename, FileMode.Create))
            {
                serializer.Serialize(stream, configuration);
            }
        }

        public void SaveDeployParameters(DeployConfiguration configuration, DeployParameters parameters)
        {
            if (configuration == null)
            {
                configuration = new DeployConfiguration();
            }

            if (configuration.Parameters == null)
            {
                configuration.Parameters = new List<DeployParameters>();
            }

            DeployParameters oldparameters = configuration.Parameters.Where(p => p.HostName.Equals(parameters.HostName, StringComparison.OrdinalIgnoreCase)).FirstOrDefault();

            if (oldparameters != null)
            {
                configuration.Parameters.Remove(oldparameters);
            }

            configuration.Parameters.Add(parameters);
            this.SaveConfiguration(configuration);
        }

        public DeployParameters GetDeployParametersByHostName(DeployConfiguration configuration, string hostName)
        {
            if (configuration == null || configuration.Parameters == null)
            {
                return null;
            }

            return configuration.Parameters.Where(p => p.HostName.Equals(hostName, StringComparison.OrdinalIgnoreCase)).FirstOrDefault();
        }

        private string GetFileName()
        {
            return "DeployConfiguration.xml";
        }
    }
}
