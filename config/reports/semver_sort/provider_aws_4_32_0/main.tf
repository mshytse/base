terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.32.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket" "this" {
  bucket_prefix = "semver-sort-aws-4320-"
  force_destroy = true
}

output "provider_version" {
  value = "4.32.0"
}

output "bucket_id" {
  value = aws_s3_bucket.this.id
}
