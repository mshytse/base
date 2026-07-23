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
# create_bucket=false → no real bucket; still needs AWS pcfg for provider init.
module "bucket" {
  source  = "terraform-aws-modules/s3-bucket/aws"
  version = "3.4.0"

  create_bucket = false
}

output "module_version" {
  value = "3.4.0"
}
