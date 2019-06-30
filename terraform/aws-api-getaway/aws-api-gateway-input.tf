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

