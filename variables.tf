variable "vpc_cidr_block" {
  description = "CIDR block for the main VPC"
}

variable "public_subnet_cidr" {
  description = "CIDR block for the first public subnet"
}

variable "public_subnet_az" {
  description = "Availability Zone for the first public subnet"
}

variable "public_subnet_b_cidr" {
  description = "CIDR block for the second public subnet"
}

variable "public_subnet_b_az" {
  description = "Availability Zone for the second public subnet"
}

variable "private_subnet_cidr" {
  description = "CIDR block for the first private subnet"
}

variable "private_subnet_az" {
  description = "Availability Zone for the first private subnet"
}

variable "private_subnet_b_cidr" {
  description = "CIDR block for the second private subnet"
}

variable "private_subnet_b_az" {
  description = "Availability Zone for the second private subnet"
}

variable "admin_cidr" {
  description = "Your IP address in CIDR format for SSH access, for example 203.0.113.10/32"
}

variable "instance_type" {
  description = "EC2 instance type for the application instances"
}

variable "s3_bucket_name" {
  description = "Globally unique S3 bucket name"
}

variable "cpu_alarm_threshold" {
  description = "Average CPU percentage that triggers the CloudWatch alarm"
}

variable "slack_webhook_url" {
  description = "Slack incoming webhook URL for alert delivery"
  sensitive   = true
}
