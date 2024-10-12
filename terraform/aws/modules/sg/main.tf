resource "aws_security_group" "this" {
  name        = var.name
  description = var.description
  vpc_id      = var.vpc_id

  tags = var.tags

  # dynamic "ingress" {
  #   for_each = var.ingress
  #   content {
  #     from_port       = ingress.value["from_port"]
  #     to_port         = ingress.value["to_port"]
  #     protocol        = ingress.value["protocol"]
  #     cidr_blocks     = lookup(ingress.value, "cidr_blocks", null)
  #     security_groups = lookup(ingress.value, "security_groups", null)
  #   }
  # }
}

resource "aws_security_group_rule" "this" {
  for_each          = { for i, rule in var.rules : i => rule }
  type              = each.value["type"]
  security_group_id = aws_security_group.this.id
  cidr_blocks       = lookup(each.value, "cidr_blocks", null)
  from_port         = lookup(each.value, "from_port", null)
  protocol          = lookup(each.value, "protocol", null)
  to_port           = lookup(each.value, "to_port", null)
  description       = lookup(each.value, "description", null)
}
