
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

  root_block_device {
    volume_size = var.root_volume_size   # configurable
    volume_type = "gp3"                  # gp3 is cheaper + flexible, gp2 also works
    delete_on_termination = true
  }

  user_data     = var.user_data

  iam_instance_profile = var.iam_instance_profile


  tags = var.tags
}

resource "null_resource" "provision" {
  count = var.enable_provisioner ? 1 : 0  #

  provisioner "file" {
  source      = var.provisioner_script # Local script path
  destination = "/tmp/setup.sh"        # Remote destination

  connection {
      type        = "ssh"
      user        = var.provisioner_ssh_user
      private_key = var.provisioner_private_key_path
      host        = var.provisioner_use_private_ip ? aws_instance.this.private_ip : aws_instance.this.public_ip
    }
}

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/setup.sh",
      "sudo /tmp/setup.sh"
    ]
    connection {
      type        = "ssh"
      user        = var.provisioner_ssh_user
      private_key = var.provisioner_private_key_path
      host        = var.provisioner_use_private_ip ? aws_instance.this.private_ip: aws_instance.this.public_ip
    }
  }
}