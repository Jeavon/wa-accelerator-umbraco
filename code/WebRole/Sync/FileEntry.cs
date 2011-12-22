using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Microsoft.Samples.UmbracoAccelerator.Sync
{
    public class FileEntry
    {
        public DateTime LocalLastModified { get; set; }
        public DateTime CloudLastModified { get; set; }
        public bool IsDirectory { get; set; }
    }
}