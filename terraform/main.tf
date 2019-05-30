terraform {
  required_version = "~> 0.12.0"
}

provider "aws" {
  region = "${var.aws_region}"
}

module "lambda_function" {
  source             = "./aws-lambda/"
  function_name      = "${var.function_name}"
  function_code_file = "${var.function_code_file}"
}

module "api_gateway" {
  source            = "./aws-api-getaway/"
  api_name          = "${var.api_name}"
  api_description   = "${var.api_description}"
  lambda_name       = "${module.lambda_function.function_name}"
  lambda_invoke_arn = "${module.lambda_function.function_invoke_arn}"
}