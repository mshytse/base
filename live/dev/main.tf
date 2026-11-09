variable "tg" {
  default = "tg"
}
resource "terraform_data" "x" {
  input = var.tg
}
