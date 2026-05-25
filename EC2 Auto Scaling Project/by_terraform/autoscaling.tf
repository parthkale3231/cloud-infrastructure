resource "aws_autoscaling_group" "app_asg" {
  name                = "free-tier-asg"
  desired_capacity    = var.desired_capacity
  max_size            = var.max_size
  min_size            = var.min_size
  vpc_zone_identifier = [
    aws_subnet.public_1.id,
    aws_subnet.public_2.id
  ]

  health_check_type         = "EC2"
  health_check_grace_period = 300

  launch_template {
    id      = aws_launch_template.app_template.id
    version = "$Latest"
  }

  instance_refresh {
    strategy = "Rolling"

    preferences {
      min_healthy_percentage = 50
      instance_warmup        = 120
    }
  }

  tag {
    key                 = "Name"
    value               = "terraform-asg-instance"
    propagate_at_launch = true
  }
}