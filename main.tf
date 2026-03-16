resource "aws_s3_bucket" "my_bucket" {
  bucket = var.bucket_name

  tags = {
    Name        = "Terraform-Lab-Bucket"
    Environment = "Dev"
  }
}

terraform {
  backend "s3" {
    bucket         = "terraform-state-devsecops-123"
    key            = "s3-project/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}

output "alb_dns" {
  value       = aws_lb.app_lb.dns_name
  description = "Public URL of the application"
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  required_version = ">= 1.0"
}

provider "aws" {
  region = "us-east-1"
}
