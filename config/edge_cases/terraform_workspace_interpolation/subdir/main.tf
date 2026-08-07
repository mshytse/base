# Same template as root, for use as Terraform working directory = subdir.
# Module path is relative to this dir.
#
# Expect: path_root still ".", abspath_root / path_cwd end with .../subdir,
# module.path_module == "../modules/probe" (vs "./modules/probe" at repo root).
#
# terraform.applying is ephemeral (OpenTofu 1.12+ / TF 1.10+): cannot go into
# resource input, normal outputs, or local-exec command (stdout gets suppressed).
# Provisioner running at all == apply phase.

locals {
  interpolations = {
    terraform_workspace     = terraform.workspace
    path_module             = path.module
    path_root               = path.root
    path_cwd                = path.cwd
    abspath_module          = abspath(path.module)
    abspath_root            = abspath(path.root)
    derived_name_from_tf_ws = "${terraform.workspace}-resource"
  }
}

resource "terraform_data" "interpolation_probe" {
  input = local.interpolations
}

module "probe" {
  source = "../modules/probe"
}

# Do not interpolate terraform.applying - OpenTofu suppresses provisioner stdout
# when the config references an ephemeral value.
resource "terraform_data" "runtime_env" {
  triggers_replace = [timestamp()]

  provisioner "local-exec" {
    command = <<-EOT
      echo "runtime_env provisioner running (apply phase; terraform.applying would be true)"
      printenv | grep '^SCALR_' | sort || true
    EOT
  }
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
