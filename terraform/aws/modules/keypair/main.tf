resource "tls_private_key" "this" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "local_file" "private_key" {
  content  = tls_private_key.this.private_key_pem
  filename = "${var.key_name}_private_key.pem"
}

resource "local_file" "public_key" {
  content  = tls_private_key.this.public_key_pem
  filename = "${var.key_name}_public_key.pem"
}

resource "aws_key_pair" "this" {
  key_name   = var.key_name
  public_key = tls_private_key.this.public_key_openssh
}
