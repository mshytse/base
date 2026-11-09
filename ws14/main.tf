variable "quantity" {
  default = 0
}
variable "prefix" {
  default = "dflt"
}
resource "terraform_data" "x" {
  input = "${var.prefix}-${var.quantity}"
}
