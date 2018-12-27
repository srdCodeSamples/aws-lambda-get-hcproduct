using System;
using System.Collections.Generic;
using System.Text;

namespace AwsGetHcProduct.Classes
{
    // Expected input for the function
    public class Input
    {
        public string Product { get; set; }
        public string Version { get; set; }
        public string Arch { get; set; }
        public string Os { get; set; }       
    }
}
