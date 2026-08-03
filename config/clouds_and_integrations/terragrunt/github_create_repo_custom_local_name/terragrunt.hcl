# SCALRCORE-37576 terragrunt wrapper.
# Reuses TF from ../../github_create_repo_custom_local_name
#
# Same Scalr PCFG setup as the plain Terraform fixture:
#   custom provider type "gh" + GitHub PAT, linked to workspace.
# Run as Terragrunt workspace (agent + celery).

terraform {
  source = "../../github_create_repo_custom_local_name"
}

inputs = {
  repository_name = "tg-gh-pcfg-local-name-test-delete-me"
}
