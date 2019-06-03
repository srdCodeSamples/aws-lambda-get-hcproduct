variable "function_name" {
  type        = "string"
  default     = "hc-get-product"
  description = "name of the lambda function"
}

variable "function_code_file" {
  type        = "string"
  description = "Path to the file containig the labda. On consecutive applies the function will be re-deployed if the file is not the same (even if contetns are not changed)."
}
