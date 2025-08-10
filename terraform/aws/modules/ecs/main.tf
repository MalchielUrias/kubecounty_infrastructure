data "aws_availability_zones" "available" {}

data "local_file" "container_definitions" {
  filename = var.container_definitions_json
}

module "ecs_cluster" {
  source = "terraform-aws-modules/ecs/aws"
  version = "6.2.1"

  # Pass through required variables
  cluster_name       = var.cluster_name
  
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

  # cluster config
  cluster_configuration = {
    execute_command_configuration = {
      logging = "OVERRIDE"
      log_configuration = {
        cloud_watch_log_group_name = "/aws/ecs/aws-ec2"
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

#### ECS Service 

module "ecs_service" {
  source = "terraform-aws-modules/ecs/aws//modules/service"

  # Service
  name        = var.service_name
  cluster_arn = module.ecs_cluster.arn

  # Task Definition
  requires_compatibilities = ["EC2"]
  capacity_provider_strategy = {
    # On-demand instances
    on_demand_capacity = {
      capacity_provider = module.ecs_cluster.autoscaling_capacity_providers["on_demand"].name
      weight            = 1
      base              = 1
    }
  }

  volume_configuration = {
    name = "ebs-volume"
    managed_ebs_volume = {
      encrypted        = true
      file_system_type = "xfs"
      size_in_gb       = 5
      volume_type      = "gp3"
    }
  }

  volume = {
    my-vol = {},
    ebs-volume = {
      name                = "ebs-volume"
      configure_at_launch = true
    }
  }

  # Container definition(s)
  # container_definitions = var.container_definitions
  container_definitions = data.local_file.container_definitions.content

  load_balancer = {
    service = {
      target_group_arn = var.target_group_arn
      container_name   = var.container_name
      container_port   = var.container_port
    }
  }

  subnet_ids = var.service_subnet_ids
  security_group_ingress_rules = var.security_group_ingress_rules

  tags = var.tags
}


#### ASG


#### CLW


#### ELB