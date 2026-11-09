variable "infra_var" {
  default = "infra"
}
resource "terraform_data" "x" {
  input = var.infra_var
}
