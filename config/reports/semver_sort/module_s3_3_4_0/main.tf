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

# SCALRCORE-39212: lex puts 3.4.0 after 3.14.0; semver puts 3.4.0 first.
# Real bucket required so module usage shows up in reports.
module "bucket" {
  source  = "terraform-aws-modules/s3-bucket/aws"
  version = "3.4.0"

  bucket_prefix = "semver-sort-s3-340-"
  force_destroy = true
}

output "module_version" {
  value = "3.4.0"
}

output "bucket_id" {
  value = module.bucket.s3_bucket_id
}
