# Probe terraform / path interpolations.
# With SCALR_RUNNER_BACKEND=remote + workspaces.name → terraform.workspace == "default"
# With SCALR_RUNNER_BACKEND=cloud               → terraform.workspace == Scalr workspace name

locals {
  interpolations = {
    terraform_workspace     = terraform.workspace
    path_module             = path.module
    path_root               = path.root
    path_cwd                = path.cwd
    derived_name_from_tf_ws = "${terraform.workspace}-resource"
  }
}

resource "terraform_data" "interpolation_probe" {
  input = local.interpolations
}

output "interpolations" {
  value = local.interpolations
}

output "terraform_workspace" {
  value = terraform.workspace
}
