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

  dynamic "environment" {
    for_each = length(var.environment_variables) > 0 ? [1] : []
    
    content {
      variables = var.environment_variables
    }
  }

  lifecycle {
    create_before_destroy = true
  }
}