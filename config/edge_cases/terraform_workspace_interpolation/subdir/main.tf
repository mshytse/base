# Same template as root, for use as Terraform working directory = subdir.
# Module path is relative to this dir.

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

module "probe" {
  source = "../modules/probe"
}

output "root" {
  value = local.interpolations
}

output "module" {
  value = module.probe.interpolations
}

output "terraform_workspace" {
  value = terraform.workspace
}
