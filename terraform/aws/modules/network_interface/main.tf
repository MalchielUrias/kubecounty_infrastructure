resource "aws_network_interface" "network_interface" {
  source_dest_check = false
  subnet_id         = var.public_subnet_id
  security_groups   = var.security_groups

  tags = {
    Name = "nat-instance-network-interface-${var.interface_name}"
  }
}
