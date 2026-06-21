resource "aws_sns_topic" "alerts" {
  name = "app-alerts"

  tags = {
    Name        = "app-alerts"
    Environment = "dev"
    ManagedBy   = "Terraform"
  }
}

resource "aws_cloudwatch_metric_alarm" "high_cpu" {
  alarm_name          = "app-high-cpu"
  alarm_description   = "Triggers when average EC2 CPU exceeds the threshold"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  threshold           = var.cpu_alarm_threshold
  period              = 300
  statistic           = "Average"
  namespace           = "AWS/EC2"
  metric_name         = "CPUUtilization"
  treat_missing_data  = "notBreaching"
  alarm_actions       = [aws_sns_topic.alerts.arn]
  ok_actions          = [aws_sns_topic.alerts.arn]

  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.app.name
  }

  tags = {
    Name        = "app-high-cpu"
    Environment = "dev"
    ManagedBy   = "Terraform"
  }
}
