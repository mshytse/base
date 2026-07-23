terraform {
  # SCALRCORE-39212: OpenTofu-only (Scalr keeps separate TF vs OpenTofu version lists).
  # Lex puts 1.9.0 after 1.10.x; semver puts 1.9.0 before 1.10.x. Floor is 1.6.0.
  required_version = "= 1.6.0"
}

resource "terraform_data" "this" {
  input = "opentofu-1.6.0"
}

output "opentofu_version_pin" {
  value = "1.6.0"
}
