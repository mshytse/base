# Root probe + local module. Compare path.module / path.root / path.cwd
# across root vs ./modules/probe.
#
# path.root / path.module are usually RELATIVE ("." for root module). That stays
# "." even when Scalr working dir is "subdir" - because subdir IS the root then.
# Use abspath(...) or path.cwd to see absolute paths (those include .../subdir).
#
# terraform.applying is false at plan time (and thus in state outputs). Apply-time
# true only shows in the local-exec provisioner log below.
#
# SCALR_RUNNER_BACKEND=remote → terraform.workspace == "default"
# SCALR_RUNNER_BACKEND=cloud  → terraform.workspace == Scalr workspace name

locals {
  interpolations = {
    terraform_workspace     = terraform.workspace
    terraform_applying      = terraform.applying
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
  source = "./modules/probe"
}

# Apply-only: terraform.applying=true here; also dump SCALR_* runtime env.
resource "terraform_data" "runtime_env" {
  triggers_replace = [timestamp()]

  provisioner "local-exec" {
    command = <<-EOT
      echo "terraform.applying=${terraform.applying}"
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

output "terraform_applying" {
  description = "Always false in plan/state; see terraform_data.runtime_env apply log for true"
  value       = terraform.applying
}
