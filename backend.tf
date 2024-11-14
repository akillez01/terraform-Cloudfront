# Backend do Terraform com S3
terraform {
  backend "s3" {
    bucket  = "ada-s3-achilles"
    key     = "terraform-state"
    region  = "us-east-1"
    encrypt = true
  }
}

