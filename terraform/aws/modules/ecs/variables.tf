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