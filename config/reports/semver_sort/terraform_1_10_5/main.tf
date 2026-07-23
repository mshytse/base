terraform {
  required_version = "= 1.10.5"
}

resource "terraform_data" "this" {
  input = "terraform-1.10.5"
}

output "terraform_version_pin" {
  value = "1.10.5"
}
