terraform {
  required_version = "~> 0.12.0"
}

data "aws_region" "current" {}

data "aws_caller_identity" "current" {}

resource "aws_api_gateway_rest_api" "API" {
  name        = "${var.api_name}"
  description = "${var.api_description}"
}

resource "aws_api_gateway_resource" "download" {
  rest_api_id = "${aws_api_gateway_rest_api.API.id}"
  parent_id   = "${aws_api_gateway_rest_api.API.root_resource_id}"
  path_part   = "download"
}

resource "aws_api_gateway_deployment" "prod" {
  depends_on = ["aws_api_gateway_integration.lambda_integration"]

  rest_api_id = "${aws_api_gateway_rest_api.API.id}"
  stage_name  = "prod"
}
