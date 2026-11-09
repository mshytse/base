variable "a" {
  type    = string
  default = "a-default"
}
resource "terraform_data" "x" {
  input = "${var.a}-${var.b}"
}
output "out" { value = terraform_data.x.output }
