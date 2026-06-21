# Terraform AWS Lab

This project builds a small AWS network and compute setup with Terraform.

## What It Creates

- a VPC
- one public subnet
- a second public subnet for the load balancer
- two private subnets for the application layer
- an Internet Gateway
- a NAT Gateway for private subnet outbound access
- route tables and associations
- an Application Load Balancer
- a target group and listener
- an Auto Scaling Group for private app instances
- an S3 bucket
- an IAM role and instance profile so EC2 can access S3
- a security group for web instances

## Project Layout

- `provider.tf`: AWS provider and Terraform provider version
- `backend.tf`: remote state configuration
- `variables.tf`: input values for the infrastructure
- `vpc.tf`: VPC, subnets, routing, IGW, NAT
- `alb.tf`: application load balancer and target group
- `autoscaling.tf`: launch template and Auto Scaling Group
- `security_groups.tf`: security group rules
- `ec2.tf`: EC2 instances
- `s3.tf`: S3 bucket and IAM access for EC2
- `outputs.tf`: useful IDs after apply
- `bootstrap/`: one-time setup for S3 backend and DynamoDB locking

## Remote State Bootstrap

Terraform remote state needs the S3 bucket and DynamoDB table to exist before the main project can use them.

Run the bootstrap project first:

```bash
cd bootstrap
terraform init
terraform apply
```

After the bucket and lock table exist, return to the main folder and migrate state:

```bash
terraform init -migrate-state
```

## Main Workflow

```bash
terraform plan
terraform apply
terraform destroy
```

## Notes

- The public subnet is used for internet-facing resources and the NAT gateway.
- The load balancer uses both public subnets for high availability.
- The private subnets use the NAT gateway for outbound internet access.
- EC2 permissions to S3 come from IAM roles, not from the VPC itself.
