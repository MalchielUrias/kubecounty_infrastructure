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
  for_each          = { for i, ingress in var.ingress : i => ingress }
  type              = each.value["type"]
  security_group_id = aws_security_group.this.id
  cidr_blocks       = each.value["cidr_blocks"]
  from_port         = each.value["from_port"]
  protocol          = each.value["protocol"]
  to_port           = each.value["to_port"]
  description       = lookup(each.value, "description", null)
}
