output "apigw_endpoint" {
  value = "${module.api_gateway.endpoint_prod}"
}

output "download_url" {
  value = "${module.api_gateway.download_url_prod}"
}