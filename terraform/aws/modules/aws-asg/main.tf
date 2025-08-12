module "asg" {
  source  = "terraform-aws-modules/autoscaling/aws"
  version = "9.0.1"

  # Autoscaling group
  name = var.asg_name

  min_size                  = var.min_size
  max_size                  = var.max_size
  desired_capacity          = var.desired_capacity
  wait_for_capacity_timeout = 0
  health_check_type         = "EC2"
  vpc_zone_identifier       = var.vpc_zone_identifier

  initial_lifecycle_hooks = var.initial_lifecycle_hooks

  # [
  #   {
  #     name                  = "ExampleStartupLifeCycleHook"
  #     default_result        = "CONTINUE"
  #     heartbeat_timeout     = 60
  #     lifecycle_transition  = "autoscaling:EC2_INSTANCE_LAUNCHING"
  #     notification_metadata = jsonencode({ "hello" = "world" })
  #   },
  #   {
  #     name                  = "ExampleTerminationLifeCycleHook"
  #     default_result        = "CONTINUE"
  #     heartbeat_timeout     = 180
  #     lifecycle_transition  = "autoscaling:EC2_INSTANCE_TERMINATING"
  #     notification_metadata = jsonencode({ "goodbye" = "world" })
  #   }
  # ]

  instance_refresh = {
    strategy = "Rolling"
    preferences = {
      checkpoint_delay       = 600
      checkpoint_percentages = [35, 70, 100]
      instance_warmup        = 300
      min_healthy_percentage = 50
      max_healthy_percentage = 100
    }
    triggers = ["tag"]
  }

  # Launch template
  launch_template_name        = var.launch_template_name
  launch_template_description = var.launch_template_description
  update_default_version      = true

  image_id          = var.asg_image_id
  instance_type     = var.asg_instance_type
  ebs_optimized     = true
  enable_monitoring = true

  # IAM role & instance profile
  create_iam_instance_profile = true
  iam_role_name               = "asg-instance-profile"
  iam_role_path               = "/ec2/"
  iam_role_description        = "IAM role example"
  iam_role_tags = {
    CustomIamRole = "Yes"
  }
  iam_role_policies = {
    AmazonSSMManagedInstanceCore = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
  }

  block_device_mappings = [
    {
      # Root volume
      device_name = "/dev/xvda"
      no_device   = 0
      ebs = {
        delete_on_termination = true
        encrypted             = true
        volume_size           = var.asg_root_volume_size
        volume_type           = "gp2"
      }
    }, {
      device_name = "/dev/sda1"
      no_device   = 1
      ebs = {
        delete_on_termination = true
        encrypted             = true
        volume_size           = var.asg_sec_volume_size
        volume_type           = "gp2"
      }
    }
  ]

  capacity_reservation_specification = {
    capacity_reservation_preference = "open"
  }

  cpu_options = {
    core_count       = var.asg_cpu_core_count
    threads_per_core = var.asg_cpu_threads_per_core
  }

  credit_specification = {
    cpu_credits = "standard"
  }

  instance_market_options = {
    market_type = var.instance_market_options
    spot_options = {
      block_duration_minutes = 60
    }
  }

  # This will ensure imdsv2 is enabled, required, and a single hop which is aws security
  # best practices
  # See https://docs.aws.amazon.com/securityhub/latest/userguide/autoscaling-controls.html#autoscaling-4
  metadata_options = {
    http_endpoint               = "enabled"
    http_tokens                 = "required"
    http_put_response_hop_limit = 1
  }

  network_interfaces = [
    {
      delete_on_termination = true
      description           = "eth0"
      device_index          = 0
      security_groups       = var.asg_security_groups
      subnet_id             = var.asg_subnet_id
    },
    {
      delete_on_termination = true
      description           = "eth1"
      device_index          = 1
      security_groups       = var.asg_security_groups
      subnet_id             = var.asg_subnet_id
    }
  ]

  tag_specifications = [
    {
      resource_type = "instance"
      tags          = { WhatAmI = "Instance" }
    },
    {
      resource_type = "volume"
      tags          = { WhatAmI = "Volume" }
    },
    {
      resource_type = "spot-instances-request"
      tags          = { WhatAmI = "SpotInstanceRequest" }
    }
  ]

  tags = {
    Environment = "dev"
    Project     = "megasecret"
  }

  user_data              = var.user_data
}