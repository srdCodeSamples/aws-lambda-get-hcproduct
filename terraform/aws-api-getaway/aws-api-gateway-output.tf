output "endpoint_prod" {
  value = aws_api_gateway_deployment.prod.invoke_url
}

output "download_url_prod" {
  value = "${aws_api_gateway_deployment.prod.invoke_url}/download"
}

