variable "api_name" {
  type        = string
  description = "name of the API gateway"
}

variable "api_description" {
  type        = string
  default     = ""
  description = "description of the API gateway"
}

variable "lambda_name" {
  type        = string
  description = "name of the lambda fucntion to integrate with the API gateway"
}

variable "lambda_invoke_arn" {
  type        = string
  description = "the lambda function invokation arn to use for the API gatway integration"
}

variable "api_deployments" {
  type        = list
  description = "a list representing deployments of the API. Every time an item is added a new deployment will be created. Do not remove items once created"
  default     = ["v0.1.0"]
}

variable "prod_deployment_id" {
  type        = number
  description = "The index in the api_deployments list of the deployment to associate with the prod stage."
  default     = 0
}
