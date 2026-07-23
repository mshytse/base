module "label" {
  source  = "cloudposse/label/null"
  version = "0.9.0"

  namespace = "qa"
  stage     = "semver"
  name      = "label-0-9-0"
}

output "module_version" {
  value = "0.9.0"
}

output "id" {
  value = module.label.id
}
