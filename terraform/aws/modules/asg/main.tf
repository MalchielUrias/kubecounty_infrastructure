resource "aws_launch_template" "this" {
  name = "${var.name}-launch-template"

  instance_type = var.instance_type
  image_id      = var.ami_id

  network_interfaces {
    associate_public_ip_address = var.associate_public_ip
    security_groups             = var.security_group_ids
  }
}

resource "aws_autoscaling_group" "this" {
  name                = var.name
  max_size            = var.max_size
  min_size            = var.min_size
  desired_capacity    = var.desired_capacity
  vpc_zone_identifier = var.vpc_zone_identifier

  mixed_instances_policy {
    instances_distribution {
      on_demand_percentage_above_base_capacity = var.on_demand_percentage_above_base_capacity
      spot_instance_pools                      = var.spot_instance_pools
    }

    launch_template {
      launch_template_specification {
        launch_template_id = aws_launch_template.this.id
        version            = "$Latest"
      }

      override {
        instance_type = var.host_types[0]
      }

      override {
        instance_type = var.host_types[1]
      }
    }
  }

  tag {
    key                 = "Name"
    value               = var.name
    propagate_at_launch = true
  }
}