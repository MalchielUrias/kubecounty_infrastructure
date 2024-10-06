resource "aws_security_group" "this" {
  name        = var.name
  description = var.description
  vpc_id      = var.vpc_id

  tags = var.tags

  dynamic "ingress" {
    for_each = var.ingress
    content {
      from_port   = ingress.value["from_port"] 
      to_port     = ingress.value["to_port"] 
      protocol    = ingress.value["protocol"] 
      cidr_blocks = lookup(ingress.value, "cidr_blocks", null)
      security_groups = lookup(ingress.value, "security_groups", null)
      self =lookup(ingress.value, "self", null)
      description = lookup(ingress.value, "description", null)
      ipv6_cidr_blocks = lookup(ingress.value, "ipv6_cidr_blocks", null)
      prefix_list_ids = lookup(ingress.value, "prefix_list_ids", null)
    }
  }
}
