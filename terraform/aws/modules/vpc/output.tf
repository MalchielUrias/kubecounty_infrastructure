output "vpc_id" {
  value = aws_vpc.this.id
}

output "public_subnet_id" {
  value = aws_subnet.public.id
}

output "public_subnet_ipv6_cidr" {
  value = aws_subnet.public.ipv6_cidr_block
}

output "private_subnet_id" {
  value = aws_subnet.private.id
}

output "private_subnet_ipv6_cidr" {
  value = aws_subnet.private.ipv6_cidr_block
}
