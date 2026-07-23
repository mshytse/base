terraform {
  required_version = "= 1.9.0"
}

resource "terraform_data" "this" {
  input = "terraform-1.9.0"
}

output "terraform_version_pin" {
  value = "1.9.0"
}
