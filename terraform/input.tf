variable "api_name" {
  type        = string
  description = "name of the API gateway"
}

variable "api_description" {
  type        = string
  default     = ""
  description = "description of the API gateway"
}

variable "api_deployments" {
  type        = list
  description = "a list representing deployments of the API. Every time an item is added a new deployment will be created. Do not remove items once created!"
  default     = ["v0.1.0"]
}

variable "prod_deployment_id" {
  type        = number
  description = "The index in the api_deployments list of the deployment to associate with the prod stage. Strats from 0."
  default     = 0
}

variable "function_name" {
  type        = string
  default     = "hc-get-product"
  description = "name of the lambda function"
}

variable "function_code_file" {
  type        = string
  description = "path to the file containig the lambda. On consecutive applies the function will be re-deployed if the file is not the same (even if contetns are not changed)."
}

variable "aws_region" {
  type        = string
  description = "the AWS region which to create the resources in"
}

