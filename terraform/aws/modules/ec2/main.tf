
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

  user_data     = var.user_data

  dynamic "provisioner" {
    for_each = var.enable_provisioner ? [1] : []
    content {
      remote-exec {
        script = var.provisioner_script

        connection {
          type        = "ssh"
          user        = var.provisioner_ssh_user
          private_key = file(var.provisioner_private_key_path)
          host        = var.provisioner_use_private_ip ? self.private_ip : self.public_ip
        }
      }
    }
  }

  iam_instance_profile = var.iam_instance_profile


  tags = var.tags
}
