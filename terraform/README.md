# Get HC product Lambda - Terraform

[![Build Status](https://travis-ci.org/srdCodeSamples/aws-lambda-get-hcproduct.svg?branch=master)](https://travis-ci.org/srdCodeSamples/aws-lambda-get-hcproduct)

A terraform project to deploy the get-hc-product lambda function to AWS and configure an API gateway to work with it.

After the terraform configuration is applied it will return an AWS API Gatway endpoint and a download urls. To use it to download an HashiCorp product need to construct an url like:

`:download_url?product=:hc_product&os=:required_os&arch=:cpu_architecture&version=:version`

The version parameter can be omitted in which case the latest stable versoin will be downloaded.

Example - download the latest terraform version for linux/x64:

`https://2z00jwdb78.execute-api.eu-central-1.amazonaws.com/prod/download?product=terraform&os=linux&arch=amd64`

## Prerequisites

* Install [terraform](https://www.terraform.io/downloads.html) 0.12.0 or later.

## Setup

* Set values for the input variables defined in `input.tf`. Refer to the variables' descriptions in order to determine what they are used for. Help on setting input variables in terraform can be found [here](https://www.terraform.io/docs/configuration/variables.html#assigning-values-to-root-module-variables)
* Set authentication to AWS, using either AWS CLI configuration file or environment variables - [help](https://www.terraform.io/docs/providers/aws/index.html#environment-variables)

## AWS Api Gateway deployments

AWS process of deploying changes to the API Gateway is as follows:

1. Make changes to the gateway properties - resources, methods etc.
2. Rollout the changes by creating a "deployment". This represent the API Gateway configuration at the time of the deployment creation.
3. Point one or more stages to this deployment.

The deployments are stored and so any stage can be pointed to any deployment as needed.

To handle this process the terraform configuration uses the `api_deployments` and `prod_deployment_id` variables.

`api_deployments` - a list of description of deployments. Every time an item is added to the list a new deployment is created. Removing items from the list is not possible as terraform would destroy the last list item and not the exact deployment that was removed.
`prod_deployment_id` - represents the list index of the deployment that the prod stage points to. The indexing starts from 0.

Changes to the variables achieves a step from the AWS API Gateway deployment process like:

1. Make changes in terraform to the API Gateway resources configuration.
2. Add an item to the `api_deployments` list to create a new deployment.
3. Change the value of `prod_deployment_id` to point to the index of new deployment in the `api_deployments` list.

Steps can be done in one or several `terraform apply` runs.

## Running terraform

* `terraform init` - initializes the terraform project directory.
* `terraform plan` - determines and displays what changes will be made to the current state of the infrastructure.
* `terraform apply` - applies any changes needed to make the infrastructure reach the desired state described in the configuration.
* `terraform destroy` - destroys any infrastructure present in current terraform state.

More help on using the terraform CLI can be found [here](https://www.terraform.io/docs/commands/index.html)

## Testing

The project includes a test with KitchenCI.

### Kitchen prerequisites

* Ruby version 2.5.1 - it is recommended to use a Ruby versions manager like rbenv. To set up rbenv on MAC:
  * Install rbenv - run brew install rbenv
  * Initialize rbenv - add to `~/.bash_profile` line `eval "$(rbenv init -)"`
  * Run `source ~/.bash_profile`
  * Install ruby 2.5.1 with rbenv - run `rbenv install 2.5.1` , check `rbenv versions`
  * Set local ruby version for the project to 2.5.1 - run `rbenv local 2.5.1` , check `rbenv local`
* Install Ruby bundler - `gem install bundler`. If using rbenv run also `rbenv rehash`.
* Install the gems from `Gemfile` - `bundle install`
* Provide values for the terraform input variables to be used for creating the test environment with terraform. Values must be provided via the `test.tfvars` file.

### Run Kitchen test

* Build kitchen environment - `bundle exec kitchen converge`
* Run kitchen tests - `bundle exec kitchen verify`
* Destroy kitchen environment - `bundle exec kitchen destroy`
* Automatically build, test, destroy - `bundle exec kitchen test`

### Test limitations

* The test checks the responses of the API Gateway created by terraform. It could potentially be broken by errors in the lambda function code itself and not in the terraform configuration!
* If running several tests in parallel you need to provide unique values for the terraform input variables => unique `test.tfvars` for each test. Otherwise resources will not be created as the variable values are used to set resource properties that must be unique (at least per AWS region).
