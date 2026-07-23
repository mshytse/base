terraform {
  required_version = "= 1.7.2"
}

resource "terraform_data" "this" {
  input = "opentofu-1.7.2"
}

output "opentofu_version_pin" {
  value = "1.7.2"
}
