output "certificate_validation_records" {
  description = "DNS records to add to Cloudflare or any other DNS provider for certificate validation"
  value = [
    for dvo in aws_acm_certificate.cert.domain_validation_options : {
      name   = dvo.resource_record_name
      type   = dvo.resource_record_type
      value  = dvo.resource_record_value
      domain = dvo.domain_name
    }
  ]
}