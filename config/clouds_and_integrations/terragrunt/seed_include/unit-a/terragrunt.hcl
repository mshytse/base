include "root" {
  path   = find_in_parent_folders("root.hcl")
  expose = true
}

terraform {
  source = "${get_parent_terragrunt_dir()}/modules/seed"
}

inputs = {
  seed_tag = include.root.locals.seed_tag
  env_name = include.root.locals.env_name
  labels = {
    check   = "terragrunt"
    leftover = "2604-to-2608"
  }
}
