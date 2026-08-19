# Manual repro for T1746 / test_google_default_labels_in_terragrunt_run_all
#
# Scalr workspace:
#   - Terragrunt run-all
#   - Working directory: unit-b
#   - include-external-dependencies = true
#   - Google PC linked (masha_says=yopt, strategy skip|update)
#   - GCS bucket for per-unit remote state
#
# Conflict key: masha_says (source hello vs PC yopt)

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