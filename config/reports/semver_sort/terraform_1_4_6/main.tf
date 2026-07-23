terraform {
  # SCALRCORE-39212: lex puts 1.9.0 after 1.10.x; semver puts 1.9.0 before 1.10.x.
  required_version = "= 1.4.6"
}

resource "terraform_data" "this" {
  input = "terraform-1.4.6"
}

output "terraform_version_pin" {
  value = "1.4.6"
}
