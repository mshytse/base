# Root probe + local module. Compare path.module / path.root / path.cwd
# across root vs ./modules/probe.
#
# path.root / path.module are usually RELATIVE ("." for root module). That stays
# "." even when Scalr working dir is "subdir" - because subdir IS the root then.
# Use abspath(...) or path.cwd to see absolute paths (those include .../subdir).
#
# terraform.applying is ephemeral (OpenTofu 1.12+ / TF 1.10+): cannot go into
# resource input, normal outputs, or local-exec command (stdout gets suppressed).
# Provisioner running at all == apply phase.
#
# SCALR_RUNNER_BACKEND=remote → terraform.workspace == "default"
# SCALR_RUNNER_BACKEND=cloud  → terraform.workspace == Scalr workspace name

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
  source = "./modules/probe"
}

# Apply-only (provisioners do not run during plan). Do not interpolate
# terraform.applying into the command - OpenTofu suppresses all provisioner
# stdout when the config references an ephemeral value.
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
