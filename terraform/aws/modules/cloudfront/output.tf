# Outputs
output "cloudfront_domain_name" {
  description = "CloudFront distribution domain name"
  value       = aws_cloudfront_distribution.site.domain_name
}

output "cloudfront_distribution_id" {
  description = "CloudFront distribution ID"
  value       = aws_cloudfront_distribution.site.id
}

output "cloudfront_distribution_arn" {
  description = "Cloudfront Distribution ARN"
  value = aws_cloudfront_distribution.site.arn
}

output "deployment_commands" {
  description = "Commands to deploy MkDocs site"
  value = <<-EOT
    # Build MkDocs site
    mkdocs build

    # Sync to S3
    aws s3 sync site/ s3://${aws_s3_bucket.docs_bucket.id} --delete

    # Create CloudFront invalidation
    aws cloudfront create-invalidation \
      --distribution-id ${aws_cloudfront_distribution.docs_distribution.id} \
      --paths "/*"
  EOT
}