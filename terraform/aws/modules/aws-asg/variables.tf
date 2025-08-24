variable "asg_name" {
  description = "Name of the Auto Scaling Group"
  type        = string
  
}

variable "asg_image_id" {
  description = "AMI ID for the Auto Scaling Group instances"
  type        = string
  
}

variable "asg_instance_type" {
  description = "Instance type for the Auto Scaling Group"
  type        = string
  default     = "t3.micro"
  
}

variable "asg_key_name" {
  description = "Key pair name for the Auto Scaling Group instances"
  type        = string
}

variable "asg_root_volume_size" {
  description = "Size of the root volume in GB"
  type        = number
  default     = 20
  
}

variable "asg_sec_volume_size" {
  description = "Size of the secondary volume in GB"
  type        = number
  default     = 30
  
}

variable "asg_cpu_core_count" {
  description = "Number of CPU cores for the Auto Scaling Group instances"
  type        = number
  default     = 1
  
}

variable "asg_cpu_threads_per_core" {
  description = "Number of threads per CPU core for the Auto Scaling Group instances"
  type        = number
  default     = 1
  
}

variable "asg_security_groups" {
  description = "List of security group IDs to associate with the Auto Scaling Group instances"
  type        = list(string)
  default     = []
  
}

variable "asg_subnet_id" {
  description = "Subnet ID for the Auto Scaling Group instances"
  type        = string
  default     = ""
  
}

variable "min_size" {
  description = "Minimum size of the Auto Scaling Group"
  type        = number
  default     = 1
  
}

variable "max_size" {
  description = "Maximum size of the Auto Scaling Group"
  type        = number
  default     = 3
  
}

variable "launch_template_name" {
  description = "Name of the launch template"
  type        = string
  default     = "example-launch-template"
  
}

variable "launch_template_description" {
  description = "Description of the launch template"
  type        = string
  default     = "Launch template for example ASG"
  
}

variable "asg_tags" {
  description = "Tags to apply to the Auto Scaling Group"
  type        = map(string)
  default     = {
    Environment = "Production"
    Project     = "ExampleProject"
  }
  
}

variable "asg_health_check_grace_period" {
  description = "Health check grace period in seconds"
  type        = number
  default     = 300
  
}

variable "initial_lifecycle_hooks" {
  description = "Initial lifecycle hooks for the Auto Scaling Group"
  type        = list(object({
    name                  = string
    default_result        = string
    heartbeat_timeout     = number
    lifecycle_transition  = string
    notification_metadata = string
  }))
  default     = []
  
}

variable "instance_refresh" {
  description = "Configuration for instance refresh"
  type = object({
    strategy     = string
    preferences  = object({
      checkpoint_delay       = number
      checkpoint_percentages = list(number)
      instance_warmup        = number
      min_healthy_percentage = number
      max_healthy_percentage = number
    })
    triggers     = list(string)
  })
  default = {
    strategy     = "Rolling"
    preferences  = {
      checkpoint_delay       = 600
      checkpoint_percentages = [35, 70, 100]
      instance_warmup        = 300
      min_healthy_percentage = 50
      max_healthy_percentage = 100
    }
    triggers     = ["tag"]
  }
  
}

variable "desired_capacity" {
  description = "Desired capacity of the Auto Scaling Group"
  type        = number
  default     = 2
  
}

variable "vpc_zone_identifier" {
  description = "List of subnet IDs for the Auto Scaling Group"
  type        = list(string)
  default     = []
  
}

variable "instance_market_options" {
  description = "Market options for the Auto Scaling Group instances (e.g., 'spot', 'on-demand')"
  type        = string
  default     = "spot"
}

variable "user_data" {
  description = "The Base64-encoded user data to provide when launching the instance"
  type        = string
  default     = null
}

variable "protect_from_scale_in" {
  description = "Whether to protect instances from scale-in"
  type        = bool
  default     = false
  
}

