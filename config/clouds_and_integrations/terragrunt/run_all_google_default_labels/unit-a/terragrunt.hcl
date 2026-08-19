include "root" {
  path = find_in_parent_folders("root.hcl")
}

# No source labels here: bare provider block for Scalr's override to merge into.
generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite"
  contents  = <<-EOF
    provider "google" {}
  EOF
}
