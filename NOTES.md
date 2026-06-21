# Terraform Notes

This file is for quick reminders about what the infrastructure does.

## Files

- `provider.tf`: sets the AWS provider and region.
- `backend.tf`: stores Terraform state in S3 and locks it with DynamoDB.
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
- Remote state needs the S3 bucket and DynamoDB table to exist before `terraform init` can use them.
- If you are bootstrapping from scratch, create the backend resources in a separate setup first, then run `terraform init -migrate-state`.

## Remote State

- `backend.tf` stores Terraform state in S3 instead of keeping it only on your computer.
- S3 gives you durable shared state for the whole team.
- DynamoDB is used for state locking so two people do not edit state at the same time.
- The lock prevents race conditions and state corruption during `terraform apply`.
- This setup is safer for collaboration and more professional for real projects.

## Bootstrap Order

1. Create the S3 bucket and DynamoDB table first.
2. Add the `backend "s3"` configuration.
3. Run `terraform init -migrate-state`.
4. After that, Terraform will store and lock state remotely.

## Terraform Init Flags

- `terraform init -migrate-state` moves existing local state into the new backend.
- Use it when you already have a state file and you are switching from local to remote state.
- `terraform init -reconfigure` tells Terraform to forget the previous backend settings and use the backend config again.
- Use `-reconfigure` when backend settings changed and you do not want Terraform to copy old state automatically.
- In this project, `-migrate-state` is the correct choice when moving your current local state to S3.

## CloudWatch Alarm Notes

- `namespace` tells CloudWatch which AWS service metric to read, such as `AWS/EC2`.
- `metric_name` is the specific metric being watched, such as `CPUUtilization`.
- `threshold` is the limit that triggers the alarm, such as `50` percent CPU.
- `comparison_operator` controls how the metric is compared to the threshold, such as `GreaterThanThreshold`.
- `period` is the time window for each check, measured in seconds. `300` means 5 minutes.
- `evaluation_periods` is how many consecutive periods must breach the threshold before the alarm fires.
- `treat_missing_data` controls what happens when CloudWatch has no data. `notBreaching` avoids false alarms from gaps.
- `alarm_actions` are triggered when the alarm enters the `ALARM` state.
- `ok_actions` are triggered when the alarm returns to normal.
- Using the Auto Scaling Group name as a dimension makes the alarm track the app layer instead of one EC2 instance.
- SNS is often used as the alert destination, then Slack can be added later through a Slack integration or webhook bridge.
- A raw SNS HTTPS subscription can point at a Slack webhook URL, but SNS message formatting may not be ideal for Slack without a transform layer.
- If the Slack message format looks bad, the usual fix is a small Lambda function that rewrites the SNS payload before posting to Slack.

## Naming Reminder

- Use snake_case for Terraform resource names and variables.
- Prefer clear names like `main`, `public`, and `private` over vague names like `thing` or `myVpc`.

## Recommended Build Order

1. Create the VPC first.
2. Create the public and private subnets.
3. Create the Internet Gateway.
4. Create the NAT Gateway in a public subnet.
5. Create the route tables.
6. Associate the route tables with the subnets.
7. Create security groups.
8. Create IAM role, instance profile, and S3 permissions for EC2.
9. Create the launch template for the app instances.1
10. Create the target group for the ALB.
11. Create the Application Load Balancer in the public subnets.
12. Create the listener on the ALB.
13. Create the Auto Scaling Group in the private subnets and attach it to the target group.
14. Create the CloudWatch alarm.
15. Create the SNS topic subscription for alert delivery.
16. Bootstrap remote state with S3 and DynamoDB before using the main backend.

## Why This Order Works

- Networking must exist before instances and load balancers can attach to it.
- Security groups and IAM must exist before EC2 can launch cleanly.
- The ALB needs a target group before it can forward traffic.
- The Auto Scaling Group needs the launch template, subnets, and target group already in place.
- Monitoring comes after the app layer exists, because it needs real targets to watch.
- Remote state bootstrap is separate because the backend bucket and lock table must already exist before the main Terraform stack can use them.
