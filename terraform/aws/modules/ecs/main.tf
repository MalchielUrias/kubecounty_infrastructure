data "aws_availability_zones" "available" {}

data "local_file" "container_definitions" {
  filename = var.container_definitions_json
}

module "ecs_cluster" {
  source = "terraform-aws-modules/ecs/aws//modules/cluster"
  version = "6.2.1"

  # Pass through required variables
  name       = var.cluster_name
  
   default_capacity_provider_strategy = {
    on_demand_capacity = {
      weight = var.on_demand_capacity
      base   = var.on_demand_base
    }
    spot_capacity = {
      weight = var.spot_capacity
    }
    FARGATE = {
      weight = var.fargate_capacity
    }
    FARGATE_SPOT = {
      weight = var.fargate_spot_capacity
    }
  }

  autoscaling_capacity_providers = {
    # On-demand instances
    on_demand = {
      auto_scaling_group_arn         = var.auto_scaling_group_arn
      managed_draining               = "ENABLED"
      managed_termination_protection = "ENABLED"

      managed_scaling = {
        maximum_scaling_step_size = 5
        minimum_scaling_step_size = 1
        status                    = "ENABLED"
        target_capacity           = 80
      }
    }
    # Spot instances
    spot = {
      auto_scaling_group_arn         = var.spot_auto_scaling_group_arn
      managed_draining               = "ENABLED"
      managed_termination_protection = "ENABLED"

      managed_scaling = {
        maximum_scaling_step_size = 5
        minimum_scaling_step_size = 1
        status                    = "ENABLED"
        target_capacity           = 90
      }
    }
  }

  # Add default tags + merge with user-provided tags
  tags = merge(
    {
      Owner       = var.owner_tag
    },
    var.tags
  )
}

