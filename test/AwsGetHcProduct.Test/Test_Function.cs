using System;
using Xunit;
using HcGetProduct;
using HcGetProduct.Classes;
using AwsGetHcProduct;
using AwsGetHcProduct.Classes;

namespace AwsGetHcProduct.Test
{
    public class Test_Function
    {
        private readonly HcReleaseData hcData;
        private readonly string hcLinkPattern = "https://.*";

        public Test_Function()
        {
            hcData = null;
            hcData = HcHelpers.GetHcProductReleasesData("terraform").Result;
        }

        [Fact]
        public void IsBuildUrlRetruned()
        {
            Input input = new Input
            {
                Product = "terraform",
                Os = "linux",
                Arch = "amd64"
            };
            string result = String.Empty;

            Function lmbdaInstance = new Function();

            result = lmbdaInstance.FunctionHandler(input, null);

            Assert.NotEqual(result, String.Empty);
            Assert.Matches(hcLinkPattern, result);
        }
    }
}
