terraform {
  backend "s3" {
    bucket         = "terraform-aws-waelt-state"
    key            = "dev/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-state-locks"
    encrypt        = true
  }
}
