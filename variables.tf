variable "vpc_cidr_block" {
  default = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
  default = "10.0.1.0/24"
}

variable "public_subnet_az" {
  default = "us-east-1a"
}

variable "private_subnet_cidr" {
  default = "10.0.2.0/24"
}

variable "private_subnet_az" {
  default = "us-east-1b"
}

variable "admin_cidr" {
  description = "Your IP address in CIDR format for SSH access, for example 203.0.113.10/32"
  default     = "0.0.0.0/0"
}

variable "instance_type" {
  default = "t2.micro"
}
