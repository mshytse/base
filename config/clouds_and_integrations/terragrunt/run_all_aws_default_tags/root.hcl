# Manual repro for T1745 / test_aws_default_tags_in_terragrunt_run_all
#
# Scalr workspace:
#   - Terragrunt run-all
#   - Working directory: unit-b
#   - include-external-dependencies = true
#   - AWS PC linked with default tags, e.g.:
#       managedBy   = scalr.io
#       Environment = test-automation
#     strategy = update
#   - Export shell variables = true (S3 backend auth)
#
# Expected tags_all (both units): PC tags + Owner=qa-team from source.
# Bug shape seen in e2e: PC tags present, Owner missing.

remote_state {
  backend = "s3"
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }
  config = {
    bucket  = "bucket-for-storage-profile"
    key     = "${get_env("SCALR_WORKSPACE_ID")}/${path_relative_to_include()}/terraform.tfstate"
    region  = "us-east-1"
    encrypt = true
  }
}

generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite"
  contents  = <<-EOF
    provider "aws" {
      region = "us-east-1"
      default_tags {
        tags = {
          Owner    = "qa-team"
          UnitPath = "${path_relative_to_include()}"
        }
      }
    }
  EOF
}
