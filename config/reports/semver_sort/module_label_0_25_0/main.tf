module "label" {
  source  = "cloudposse/label/null"
  version = "0.25.0"

  namespace   = "qa"
  stage       = "semver"
  name        = "label-0-25-0"
  label_order = ["namespace", "stage", "name"]
}

output "module_version" {
  value = "0.25.0"
}

output "id" {
  value = module.label.id
}
