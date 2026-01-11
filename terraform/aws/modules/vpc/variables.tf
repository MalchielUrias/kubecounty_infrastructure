variable "cidr_block" {
  type = string
}

variable "ipv6_enabled" {
  type = bool
}

variable "assign_ipv6_address_on_creation" {
  type = bool
}

variable "priv_subnet_cidrs" {
  type = list(string)
}

variable "pub_subnet_cidrs" {
  type = list(string)
}

variable "name" {
  type = string
}

variable "tags" {
  type = map(string)
}

variable "enable_ssm_endpoints" {
  description = "Enable VPC endpoints for SSM (required for private subnet SSM access without NAT)"
  type        = bool
  default     = false
}

variable "vpc_endpoint_services" {
  description = "List of AWS service names to create VPC endpoints for (e.g., ['ssm', 'ssmmessages', 'ec2messages'])"
  type        = list(string)
  default     = []
}

variable "vpc_endpoint_security_group_ids" {
  description = "List of security group IDs to attach to VPC endpoints. If not provided, endpoints will be created without security groups (uses default VPC security group)"
  type        = list(string)
  default     = []
}