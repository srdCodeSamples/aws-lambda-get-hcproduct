variable "api_name" {
  type        = string
  description = "name of the API gateway"
}

variable "api_description" {
  type        = string
  default     = ""
  description = "description of the API gateway"
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

