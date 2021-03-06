terraform {
  required_version = "~> 0.12.0"
}

data "aws_region" "current" {
}

data "aws_caller_identity" "current" {
}

resource "aws_api_gateway_rest_api" "API" {
  name        = var.api_name
  description = var.api_description
}

resource "aws_api_gateway_resource" "download" {
  rest_api_id = aws_api_gateway_rest_api.API.id
  parent_id   = aws_api_gateway_rest_api.API.root_resource_id
  path_part   = "download"
}

resource "aws_api_gateway_deployment" "deployments" {
  count       = length(var.api_deployments)
  depends_on  = [aws_api_gateway_integration.lambda_integration]
  description = var.api_deployments[count.index]
  rest_api_id = aws_api_gateway_rest_api.API.id
}

resource "aws_api_gateway_stage" "prod" {
  stage_name    = "prod"
  rest_api_id   = aws_api_gateway_rest_api.API.id
  deployment_id = aws_api_gateway_deployment.deployments[var.prod_deployment_id].id
}

