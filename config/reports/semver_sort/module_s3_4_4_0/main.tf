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

module "bucket" {
  source  = "terraform-aws-modules/s3-bucket/aws"
  version = "4.4.0"

  bucket_prefix = "semver-sort-s3-440-"
  force_destroy = true
}

output "module_version" {
  value = "4.4.0"
}

output "bucket_id" {
  value = module.bucket.s3_bucket_id
}
