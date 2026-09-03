# Scalr workspace:
#   - Terragrunt, run-all
#   - Env: Scalr remote backend disabled (required for run-all)
#   - Google PC linked (GCS backend auth)
#   - Working directory: config/clouds_and_integrations/terragrunt/tg_run_all_policy
#   - Policy group: policies/tg_run_all_units
#
# Expected policy check (post-plan), one row per unit:
#   unit-pass      all passed
#   unit-advisory  advisory failed
#   unit-soft      soft-mandatory failed
#   unit-hard      hard-mandatory failed

remote_state {
  backend = "gcs"
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }
  config = {
    bucket = "terragrunt-tofu-state"
    prefix = "${get_env("SCALR_WORKSPACE_ID")}/${path_relative_to_include()}"
  }
}

generate "versions" {
  path      = "versions.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
terraform {
  required_version = ">= 1.4.0"
}
EOF
}
