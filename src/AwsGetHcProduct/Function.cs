using System;
using AwsGetHcProduct.Classes;
using Amazon.Lambda.Core;
using HcGetProduct;
using HcGetProduct.Classes;
using System.Net.Http;

// Assembly attribute to enable the Lambda function's JSON input to be converted into a .NET class.
[assembly: LambdaSerializer(typeof(Amazon.Lambda.Serialization.Json.JsonSerializer))]

namespace AwsGetHcProduct
{
    public class Function
    {

        /// <summary>
        /// A function that returns a HC product's build URL based on the input
        /// </summary>
        /// <param name="input"></param>
        /// <param name="context"></param>
        /// <returns></returns>
        public string FunctionHandler(Input input, ILambdaContext context)
        {
            // Handle NRE 
            if (input == null)
            {
                throw new ArgumentNullException();
            }

            // Make sure input is lowercase
            input.Arch = input.Arch.ToLower();
            input.Os = input.Os.ToLower();
            input.Product = input.Product.ToLower();
            input.Version = input.Version.ToLower();

            // Get HC releases data for the requested product
            HcReleaseData hcData = null;
            hcData = HcHelpers.GetHcProductReleasesData(input.Product).Result;
            

            if (hcData == null)
            {
                throw new Exception($"Error getting HC Releases data for {input.Product}");
            }

            // Get the build Url based on the input data
            if (String.IsNullOrEmpty(input.Version))
            {
                input.Version = "latest";
            }

            string hcUrl = string.Empty;
            hcUrl = hcData.GetBuildUrl(input.Os, input.Arch, input.Version);

            // Retrun the found Url
            if (String.IsNullOrEmpty(hcUrl))
            {
                throw new Exception($"No build found for {input.Product}, version: {input.Version}, {input.Os}/{input.Arch}");
            }
            else
            {
                return hcUrl;
            }
        }
    }
}
