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

data "aws_caller_identity" "current" {}

output "provider_version" {
  value = "4.32.0"
}

output "account_id" {
  value = data.aws_caller_identity.current.account_id
}
