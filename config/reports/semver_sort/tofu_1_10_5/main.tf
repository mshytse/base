terraform {
  required_version = "= 1.10.5"
}

resource "terraform_data" "this" {
  input = "opentofu-1.10.5"
}

output "opentofu_version_pin" {
  value = "1.10.5"
}
