include "root" {
  path = find_in_parent_folders("root.hcl")
}

# unit-a is outside unit-b WD; only planned with include-external-dependencies.
dependencies {
  paths = ["../unit-a"]
}

# Source default_labels live only here, so unit-a shows PC labels alone.
generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite"
  contents  = <<-EOF
    provider "google" {
      default_labels = {
        team       = "frontend"
        masha_says = "hello"
        unit_path  = "unit-b"
      }
    }
  EOF
}
