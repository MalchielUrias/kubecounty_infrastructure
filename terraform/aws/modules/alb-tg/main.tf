resource "aws_lb_target_group" "this" {
  name                 = var.tg_name
  port                 = var.port
  protocol             = var.protocol
  slow_start           = var.slow_start
  vpc_id               = var.vpc_id
  target_type          = var.target_type
  deregistration_delay = var.deregistration_delay

  
  dynamic "stickiness" {
    for_each = length(keys(var.stickiness)) == 0 ? [] : [var.stickiness]
    content {
      cookie_duration = lookup(stickiness.value, "cookie_duration", 604800)
      enabled         = lookup(stickiness.value, "enabled", false)
      type            = lookup(stickiness.value, "type", "lb_cookie")
    }
  }

  dynamic "health_check" {
    for_each = length(var.health_check) == 0 ? [] : [var.health_check]

    content {
      interval            = lookup(health_check.value, "interval", null)
      path                = lookup(health_check.value, "path", null)
      healthy_threshold   = lookup(health_check.value, "healthy_threshold", null)
      unhealthy_threshold = lookup(health_check.value, "unhealthy_threshold", null)
      timeout             = lookup(health_check.value, "timeout", null)
      protocol            = lookup(health_check.value, "protocol", null)
      matcher             = lookup(health_check.value, "matcher", null)
      port                = lookup(health_check.value, "port", null)
    }
  }

  tags = merge(var.tags, { Name = var.tg_name })
}
