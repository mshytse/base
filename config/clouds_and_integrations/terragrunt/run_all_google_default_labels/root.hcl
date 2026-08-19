# Manual repro for T1746 / test_google_default_labels_in_terragrunt_run_all
#
# Scalr workspace:
#   - Terragrunt run-all
#   - Working directory: unit-b
#   - include-external-dependencies = true
#   - Google PC linked (masha_says=yopt, strategy skip|update)
#   - AWS PC + BUCKET_NAME for per-unit remote state (same as e2e)
#
# Conflict key: masha_says (source hello vs PC yopt)

locals {
  state_prefix = get_env("SCALR_WORKSPACE_ID", "manual")
}

remote_state {
  backend = "s3"
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }
  config = {
    bucket  = get_env("BUCKET_NAME")
    key     = "${local.state_prefix}/${path_relative_to_include()}/terraform.tfstate"
    region  = "us-east-1"
    encrypt = true
  }
}

generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite"
  contents  = <<-EOF
    provider "google" {
      default_labels = {
        team       = "frontend"
        masha_says = "hello"
        unit_path  = "${replace(path_relative_to_include(), "/", "_")}"
      }
    }
  EOF
}
