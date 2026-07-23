terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.52.7"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

data "aws_caller_identity" "current" {}

output "provider_version" {
  value = "4.52.7"
}

output "account_id" {
  value = data.aws_caller_identity.current.account_id
}
