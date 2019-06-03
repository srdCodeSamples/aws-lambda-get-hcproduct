# Get HC product Lambda - Terraform

A terraform project to deploy the get-hc-product lambda function to AWS and configure an API gateway to work with it.

## Prerequisites

* Install [terraform](https://www.terraform.io/downloads.html) 0.12.0 or later.

## Setup

* Set values for the input variables defined in `input.tf`. Refer to the variables' descriptions in order to determine what they are used for. Help on setting input variables in terraform can be found [here](https://www.terraform.io/docs/configuration/variables.html#assigning-values-to-root-module-variables)
* Set authentication to AWS, using either AWS CLI configuration file or environment variables - [help](https://www.terraform.io/docs/providers/aws/index.html#environment-variables)

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
