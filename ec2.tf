data "aws_ami" "amazon_linux_2023" {
  most_recent = true

  filter {
    name   = "name"
    values = ["al2023-ami-*-x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["amazon"]
}

resource "aws_instance" "public_web" {
  ami                         = data.aws_ami.amazon_linux_2023.id
  instance_type               = var.instance_type
  subnet_id                   = aws_subnet.public_subnet_a.id
  vpc_security_group_ids       = [aws_security_group.web.id]
  associate_public_ip_address = true
  iam_instance_profile        = aws_iam_instance_profile.ec2_s3_access.name

  tags = {
    Name        = "public-web-instance"
    Environment = "dev"
    ManagedBy   = "Terraform"
  }
}

resource "aws_instance" "private_web" {
  ami                   = data.aws_ami.amazon_linux_2023.id
  instance_type         = var.instance_type
  subnet_id             = aws_subnet.private_subnet_a.id
  vpc_security_group_ids = [aws_security_group.web.id]
  iam_instance_profile  = aws_iam_instance_profile.ec2_s3_access.name

  tags = {
    Name        = "private-web-instance"
    Environment = "dev"
    ManagedBy   = "Terraform"
  }
}
