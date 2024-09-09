resource "aws_instance" "k3s_box" {
  ami           = var.ami
  instance_type = var.instance_type

  tags = {
    Name = "K3s Box"
  }
}