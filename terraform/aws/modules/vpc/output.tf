# Output VPC ID
output "vpc_id" {
  value = aws_vpc.this.id
}

# ====== Output Subnet ID =======

# Priv Subnet
output "private_subnet_id" {
  value = { for val, subnet in aws_subnet.priv_subnet : val => subnet.id }
}

# Pub Subnet
output "pub_subnet_id" {
  value = { for val, subnet in aws_subnet.pub_subnet : val => subnet.id }
}