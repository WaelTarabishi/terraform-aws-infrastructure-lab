output "vpc_id" {
  value = aws_vpc.main.id
}

output "public_subnet_id" {
  value = aws_subnet.public_subnet_a.id
}

output "private_subnet_id" {
  value = aws_subnet.private_subnet_a.id
}

output "nat_gateway_id" {
  value = aws_nat_gateway.main.id
}


output "s3_bucket_name" {
  value = aws_s3_bucket.app.bucket
}

output "alb_dns_name" {
  value = aws_lb.app.dns_name
}

output "app_asg_name" {
  value = aws_autoscaling_group.app.name
}

output "alerts_topic_arn" {
  value = aws_sns_topic.alerts.arn
}
