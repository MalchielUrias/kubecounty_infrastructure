resource "aws_lb_listener" "this" {
  load_balancer_arn = var.load_balancer_arn
  port              = var.port
  protocol          = var.protocol
  default_action {
    target_group_arn = var.target_group_arn
    type             = var.action_type
  }
  tags = merge(var.tags, { "Name" = var.listener_name })
}