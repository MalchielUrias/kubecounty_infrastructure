
resource "aws_instance" "this" {
  ami           = var.ami
  instance_type = var.instance_type
  subnet_id     = var.subnet_id

  vpc_security_group_ids = var.vpc_security_group_ids

  key_name = var.key_name

  # dynamic "network_interface" {
  #   for_each = var.network_interface
  #   content {
  #     device_index         = lookup(network_interface.value, "device_index", 0)
  #     network_interface_id = lookup(network_interface.value, "network_interface_id", "")
  #   }
  # }


  tags = var.tags
}
