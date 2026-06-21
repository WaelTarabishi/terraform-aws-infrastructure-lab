variable "vpc_cidr_block" {
  default = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
  default = "10.0.1.0/24"
}

variable "public_subnet_az" {
  default = "us-east-1a"
}

variable "public_subnet_b_cidr" {
  default = "10.0.3.0/24"
}

variable "public_subnet_b_az" {
  default = "us-east-1b"
}

variable "private_subnet_cidr" {
  default = "10.0.2.0/24"
}

variable "private_subnet_az" {
  default = "us-east-1b"
}

variable "private_subnet_b_cidr" {
  default = "10.0.4.0/24"
}

variable "private_subnet_b_az" {
  default = "us-east-1c"
}

variable "admin_cidr" {
  description = "Your IP address in CIDR format for SSH access, for example 203.0.113.10/32"
  default     = "0.0.0.0/0"
}

variable "instance_type" {
  default = "t2.micro"
}

variable "s3_bucket_name" {
  description = "Globally unique S3 bucket name"
  default     = "terraform-aws-waeltarabishi-demo-bucket"
}

variable "cpu_alarm_threshold" {
  description = "Average CPU percentage that triggers the CloudWatch alarm"
  default     = 50
}

variable "slack_webhook_url" {
  description = "Slack incoming webhook URL for alert delivery"
  default     = "https://hooks.slack.com/services/REPLACE/ME/LATER"
}
