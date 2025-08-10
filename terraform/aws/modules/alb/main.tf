resource "aws_lb" "this" {
  name                       = var.lb_name
  internal                   = var.internal
  ip_address_type            = var.ip_address_type
  load_balancer_type = var.load_balancer_type
  security_groups            = var.security_groups
  subnets = var.subnets
  idle_timeout               = var.idle_timeout
  enable_deletion_protection = var.enable_deletion_protection
  access_logs {
    enabled       = false
    bucket = ""
  }
  tags = merge(var.tags, { "Name" = var.lb_name })
}