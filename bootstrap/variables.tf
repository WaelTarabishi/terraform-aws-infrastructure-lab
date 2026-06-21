variable "aws_region" {
  default = "us-east-1"
}

variable "state_bucket_name" {
  description = "Globally unique S3 bucket name for Terraform state"
  default     = "terraform-aws-waelt-state"
}

variable "lock_table_name" {
  default = "terraform-state-locks"
}

variable "environment" {
  default = "dev"
}
