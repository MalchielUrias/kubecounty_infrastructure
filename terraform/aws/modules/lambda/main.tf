resource "aws_lambda_function" "this" {
  filename         = var.filename
  function_name    = var.function_name
  role             = var.role
  handler          = var.handler
  source_code_hash = var.source_code_hash 
  runtime          = var.runtime
  publish          = var.publish
  timeout          = var.timeout
  region           = var.region

  lifecycle {
    create_before_destroy = true
  }
}