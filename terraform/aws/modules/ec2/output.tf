output "arn" {
  value = aws_instance.k3s_box.arn
}

output "public_ip" {
  value = aws_instance.k3s_box.public_ip
}