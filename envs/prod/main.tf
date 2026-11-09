resource "terraform_data" "x" {
  input = var.shared_a
}
output "shared_a" { value = var.shared_a }
