resource "aws_cloudfront_function" "this" {
  name    = var.function_name
  runtime = "cloudfront-js-2.0"
  comment = var.function_comment
  publish = true
  code    = var.code
}