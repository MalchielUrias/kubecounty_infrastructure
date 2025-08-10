data "aws_availability_zones" "available" {}

data "local_file" "container_definitions" {
  filename = var.container_definitions_json
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