variable "unit" {
  type = string
}

resource "terraform_data" "this" {
  input = var.unit
}
