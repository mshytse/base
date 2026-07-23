terraform {
  required_version = "= 1.9.0"
}

resource "terraform_data" "this" {
  input = "opentofu-1.9.0"
}

output "opentofu_version_pin" {
  value = "1.9.0"
}
