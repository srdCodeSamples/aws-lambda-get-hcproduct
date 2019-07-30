# AWS Lambda - Get HC Product

[![Build Status](https://travis-ci.org/srdCodeSamples/aws-lambda-get-hcproduct.svg?branch=master)](https://travis-ci.org/srdCodeSamples/aws-lambda-get-hcproduct)


A .NetCore AWS Lambda function to get the url of an HC product build.

This is an implemntation of [this](https://github.com/srdCodeSamples/lib-hc-get-build) library in an AWS Lambda function. The library repository is added as git submodule to the project.

## Usage

* Build (or use a [release](https://github.com/srdCodeSamples/aws-lambda-get-hcproduct/releases)) and upload to AWS Lambda.
* In AWS Lambda set the `Handler` field to `AwsGetHcProduct::AwsGetHcProduct.Function::FunctionHandler`
* Trigger the function (e.g. via an AWS API Gateway) with the required input to get the corresponding build url as string.

The input object needed by the function is:

```JSON
{
	"product": "required HC product",
	"os": "required OS",
	"arch": "required architecture",
	"version": "required version or 'latest'" 
}
```

In the `terraform` folder there is a terraform project which can be used to deploy the lambda and the needed AWS infrastructure.

## Vagrant VM

Included is a Vagrant configuration for building a VirtualBox VM. The VM runs Ubuntun/Xenial OS with .Net Core, Terraform and some other basic tools installed.

### Prerequisites

* Install VirtualBox - [instructions](https://www.virtualbox.org/wiki/Downloads)
* Install Vagrant - [instructions](https://www.vagrantup.com/downloads.html)

### Run Vagrant

* Build VM - `vagrant up`
* Login to VM - `vagrant ssh`
