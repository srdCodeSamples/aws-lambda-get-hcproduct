terraform {
  required_version = "~> 0.12.0"
}

provider "aws" {
  region  = var.aws_region
  version = "~> 2.16"
}
