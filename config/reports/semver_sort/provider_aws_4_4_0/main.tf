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

# Ticket repro pair: 4.4.0 vs 4.32.0. Needs AWS provider configuration on the workspace.
data "aws_caller_identity" "current" {}

output "provider_version" {
  value = "4.4.0"
}

output "account_id" {
  value = data.aws_caller_identity.current.account_id
}
