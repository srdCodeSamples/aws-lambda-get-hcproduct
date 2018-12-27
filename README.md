# AWS Lambda - Get HC Product

A .NetCore AWS Lambda function to get the url of an HC product build.

This is an implemntation of [this](https://github.com/srdCodeSamples/lib-hc-get-build) library in an AWS Lambda function. The library repository is added asgit submodule to the project.

## Usage

* Build (or use a [release](https://github.com/srdCodeSamples/aws-lambda-get-hcproduct/releases)) and deploy to AWS Lambda.
* Trigger the function (e.g. via an AWS API Gateway) with the required input to get the corresponding build url as string.

The input object for the function should be:

```JSON
{
	"product": "required HC product"
	"os": "required OS"
	"arch": "required architecture"
	"version": "required version or 'latest'" 
}
```
