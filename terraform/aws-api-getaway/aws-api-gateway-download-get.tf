resource "aws_api_gateway_method" "download-get" {
  rest_api_id          = "${aws_api_gateway_rest_api.API.id}"
  resource_id          = "${aws_api_gateway_resource.download.id}"
  request_validator_id = "${aws_api_gateway_request_validator.request-parameters.id}"
  http_method          = "GET"
  authorization        = "NONE"
  request_parameters = {
    "method.request.querystring.product" = true
    "method.request.querystring.os"      = true
    "method.request.querystring.arch"    = true
    "method.request.querystring.version" = false
  }
}

resource "aws_api_gateway_request_validator" "request-parameters" {
  name                        = "request-parameters-only"
  rest_api_id                 = "${aws_api_gateway_rest_api.API.id}"
  validate_request_body       = false
  validate_request_parameters = true
}

resource "aws_api_gateway_integration" "lambda_integration" {
  rest_api_id             = "${aws_api_gateway_rest_api.API.id}"
  resource_id             = "${aws_api_gateway_resource.download.id}"
  http_method             = "${aws_api_gateway_method.download-get.http_method}"
  integration_http_method = "POST"
  type                    = "AWS"
  timeout_milliseconds    = 29000
  uri                     = "${var.lambda_invoke_arn}"
  request_templates = {
    "application/json" = "${file("templates/input-map.json")}"
  }
  passthrough_behavior = "NEVER"
}

resource "aws_lambda_permission" "apigw_lambda" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = "${var.lambda_name}"
  principal     = "apigateway.amazonaws.com"

  # More: http://docs.aws.amazon.com/apigateway/latest/developerguide/api-gateway-control-access-using-iam-policies-to-invoke-api.html
  source_arn = "arn:aws:execute-api:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:${aws_api_gateway_rest_api.API.id}/*/${aws_api_gateway_method.download-get.http_method}${aws_api_gateway_resource.download.path}"
}

resource "aws_api_gateway_method_response" "download-get-301" {
  rest_api_id         = "${aws_api_gateway_rest_api.API.id}"
  resource_id         = "${aws_api_gateway_resource.download.id}"
  http_method         = "${aws_api_gateway_method.download-get.http_method}"
  status_code         = "301"
  response_parameters = { "method.response.header.Location" = true }
}

resource "aws_api_gateway_method_response" "download-get-500" {
  rest_api_id = "${aws_api_gateway_rest_api.API.id}"
  resource_id = "${aws_api_gateway_resource.download.id}"
  http_method = "${aws_api_gateway_method.download-get.http_method}"
  status_code = "500"
}

resource "aws_api_gateway_integration_response" "download-get-301" {
  rest_api_id = "${aws_api_gateway_rest_api.API.id}"
  resource_id = "${aws_api_gateway_resource.download.id}"
  http_method = "${aws_api_gateway_method.download-get.http_method}"
  status_code = "${aws_api_gateway_method_response.download-get-301.status_code}"
  response_parameters = {
    "method.response.header.Location" = "integration.response.body"
  }
  response_templates = {
    "text/html" = "${file("templates/redirect.html")}"
  }
}

resource "aws_api_gateway_integration_response" "download-get-500" {
  rest_api_id       = "${aws_api_gateway_rest_api.API.id}"
  resource_id       = "${aws_api_gateway_resource.download.id}"
  http_method       = "${aws_api_gateway_method.download-get.http_method}"
  status_code       = "${aws_api_gateway_method_response.download-get-500.status_code}"
  selection_pattern = "^(?!http).+$"
  response_templates = {
    "application/json" = "${file("templates/output-error.json")}"
  }
}
