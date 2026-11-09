variable "title" {
  default = "dflt-title"
}
variable "description" {
  default = "dflt-desc"
}
resource "terraform_data" "x" {
  input = "${var.title}"
}
