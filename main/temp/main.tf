terraform {
  required_version = "not-a-valid-constraint"
}
resource "null_resource" {}
resource "null_resource" "1invalid" {}