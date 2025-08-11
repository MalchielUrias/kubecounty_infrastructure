variable "cluster_name" {
  description = "The name of the ECS cluster"
  type        = string
}

variable "owner_tag" {
  description = "The owner tag for the ECS cluster"
  type        = string
}

variable "tags" {
  description = "Additional tags to apply to the ECS cluster"
  type        = map(string)
  default     = {}
}

variable "on_demand_capacity" {
  description = "Weight for on-demand capacity in the ECS cluster"
  type        = number
  default     = 40
}

variable "on_demand_base" {
  description = "Base for on-demand capacity in the ECS cluster"
  type        = number
  default     = 20
  
}

variable "spot_capacity" {
  description = "Weight for spot capacity in the ECS cluster"
  type        = number
  default     = 30
  
}

variable "fargate_capacity" {
  description = "Weight for Fargate capacity in the ECS cluster"
  type        = number
  default     = 20
}

variable "fargate_spot_capacity" {
  description = "Weight for Fargate Spot capacity in the ECS cluster"
  type        = number
  default     = 10
}

variable "auto_scaling_group_arn" {
  description = "ARN of the Auto Scaling Group for on-demand instances"
  type        = string
  
}

variable "spot_auto_scaling_group_arn" {
  description = "ARN of the Auto Scaling Group for spot instances"
  type        = string
}

variable "security_group_ingress_rules" {
  description = "Security group ingress rules for the ECS service"
  type        = map(object({
    from_port                    = number
    description                  = string
    referenced_security_group_id = string
  }))
  default     = {}
  
}

variable "container_port" {
  description = "Port on which the container listens"
  type        = number
  default     = 80
}

