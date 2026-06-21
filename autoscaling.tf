resource "aws_launch_template" "app" {
  name_prefix   = "app-lt-"
  image_id      = data.aws_ami.amazon_linux_2023.id
  instance_type = var.instance_type

  network_interfaces {
    associate_public_ip_address = false
    security_groups             = [aws_security_group.web.id]
  }

  iam_instance_profile {
    name = aws_iam_instance_profile.ec2_s3_access.name
  }

  user_data = base64encode(<<-EOF
              #!/bin/bash
              dnf -y install httpd
              systemctl enable httpd
              systemctl start httpd
              cat <<'HTML' > /var/www/html/index.html
              <h1>Private App Instance</h1>
              HTML
              EOF
  )

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name        = "app-instance"
      Environment = "dev"
      ManagedBy   = "Terraform"
    }
  }
}

resource "aws_autoscaling_group" "app" {
  name                = "app-asg"
  min_size            = 2
  desired_capacity    = 2
  max_size            = 4
  vpc_zone_identifier = [
    aws_subnet.private_subnet_a.id,
    aws_subnet.private_subnet_b.id,
  ]
  target_group_arns = [aws_lb_target_group.app.arn]
  health_check_type = "ELB"

  launch_template {
    id      = aws_launch_template.app.id
    version = "$Latest"
  }

  tag {
    key                 = "Name"
    value               = "app-asg-instance"
    propagate_at_launch = true
  }
}
