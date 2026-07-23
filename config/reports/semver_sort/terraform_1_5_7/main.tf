terraform {
  required_version = "= 1.5.7"
}

resource "terraform_data" "this" {
  input = "terraform-1.5.7"
}

output "terraform_version_pin" {
  value = "1.5.7"
}
