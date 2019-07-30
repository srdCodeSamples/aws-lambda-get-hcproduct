output "endpoint_prod" {
  value = aws_api_gateway_stage.prod.invoke_url
}

output "download_url_prod" {
  value = "${aws_api_gateway_stage.prod.invoke_url}/download"
}

