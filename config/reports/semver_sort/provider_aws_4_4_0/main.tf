terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.4.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

# Ticket repro: 4.4.0 vs 4.32.0. Managed resource required so provider appears in state → usage report.
resource "aws_s3_bucket" "this" {
  bucket_prefix = "semver-sort-aws-440-"
  force_destroy = true
}

output "provider_version" {
  value = "4.4.0"
}

output "bucket_id" {
  value = aws_s3_bucket.this.id
}
