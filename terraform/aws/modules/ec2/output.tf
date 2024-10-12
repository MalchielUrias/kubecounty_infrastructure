output "arn" {
  value = aws_instance.this.arn
}

output "public_ip" {
  value = aws_instance.this.public_ip
}

output "public_dns" {
  value = aws_instance.this.public_dns
}

output "primary_network_interface_id" {
  value = aws_instance.this.primary_network_interface_id
}
