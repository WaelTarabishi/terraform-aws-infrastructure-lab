# Terraform Notes

This file is for quick reminders about what the infrastructure does.

## Files

- `provider.tf`: sets the AWS provider and region.
- `variables.tf`: stores configurable values like CIDR blocks and AZs.
- `vpc.tf`: creates the VPC, subnets, internet gateway, NAT gateway, and route tables.
- `outputs.tf`: shows important IDs after `terraform apply`.

## Current Network Design

- `aws_vpc.main`: the main private network for the project.
- `aws_subnet.public_subnet_a`: public subnet for internet-facing resources and the NAT gateway.
- `aws_subnet.private_subnet_a`: private subnet for internal resources that should not be directly reachable from the internet.
- `aws_internet_gateway.main`: gives the VPC internet access through the public subnet.
- `aws_eip.nat`: static public IP for the NAT gateway.
- `aws_nat_gateway.main`: lets the private subnet reach the internet for outbound traffic.
- `aws_route_table.public`: sends public subnet traffic to the internet gateway.
- `aws_route_table.private`: sends private subnet outbound traffic to the NAT gateway.

## Important Rules

- A subnet belongs to one Availability Zone only.
- A NAT gateway must be placed in a public subnet.
- A private subnet does not get direct internet access unless it routes through a NAT gateway.
- `output` blocks are just for displaying useful IDs after deployment.

## Naming Reminder

- Use snake_case for Terraform resource names and variables.
- Prefer clear names like `main`, `public`, and `private` over vague names like `thing` or `myVpc`.
