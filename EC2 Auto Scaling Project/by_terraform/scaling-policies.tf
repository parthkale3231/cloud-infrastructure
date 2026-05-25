resource "aws_autoscaling_policy" "target_tracking" {
  name                   = "target-tracking-policy"
  autoscaling_group_name = aws_autoscaling_group.app_asg.name
  policy_type            = "TargetTrackingScaling"

  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }

    target_value = 50.0
  }
}

resource "aws_autoscaling_policy" "step_scaling" {
  name                   = "step-scaling-policy"
  autoscaling_group_name = aws_autoscaling_group.app_asg.name
  adjustment_type        = "ChangeInCapacity"
  policy_type            = "StepScaling"

  step_adjustment {
    metric_interval_lower_bound = 0
    scaling_adjustment          = 1
  }
}

resource "aws_cloudwatch_metric_alarm" "cpu_alarm" {
  alarm_name          = "high-cpu-alarm"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 300
  statistic           = "Average"
  threshold           = 70

  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.app_asg.name
  }

  alarm_description = "Scale up on high CPU"

  alarm_actions = [
    aws_autoscaling_policy.step_scaling.arn
  ]
}
resource "aws_autoscaling_schedule" "scale_up_morning" {
  scheduled_action_name  = "scale-up-morning"
  autoscaling_group_name = aws_autoscaling_group.app_asg.name
  recurrence             = "0 4 * * 1-5"

  min_size         = 1
  max_size         = 2
  desired_capacity = 2
}

resource "aws_autoscaling_schedule" "scale_down_evening" {
  scheduled_action_name  = "scale-down-evening"
  autoscaling_group_name = aws_autoscaling_group.app_asg.name
  recurrence             = "0 14 * * 1-5"

  min_size         = 1
  max_size         = 2
  desired_capacity = 1
}