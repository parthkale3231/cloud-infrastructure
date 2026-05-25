resource "aws_autoscaling_group" "asg" {
  name = "prod-app-asg"

  desired_capacity = 1
  max_size         = 2
  min_size         = 1

  vpc_zone_identifier = [
     aws_subnet.public_1.id,
     aws_subnet.public_2.id
  ]

  target_group_arns = [aws_lb_target_group.tg.arn]

  launch_template {
    id      = aws_launch_template.app_lt.id
    version = "$Latest"
  }

  health_check_type         = "ELB"
  health_check_grace_period = 300
}