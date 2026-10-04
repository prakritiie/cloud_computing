terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

# Intentionally insecure:
# S3 bucket without encryption configuration
resource "aws_s3_bucket" "insecure_bucket" {
  bucket = "devsecops-unencrypted-lab-bucket"
}

# Intentionally insecure:
# SSH exposed to the entire internet
resource "aws_security_group" "insecure_sg" {
  name = "insecure-web-sg"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}