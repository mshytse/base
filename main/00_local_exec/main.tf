data "external" "test" {
  count = var.data_count
  program = ["bash", "-c", var.program_for_data_external]
}

data "external" "test2" {
  count = var.data_count
  program = ["bash", "-c", var.program_for_data_external2]
  depends_on = [data.external.test]
}

variable "program_for_data_external" {
  type = string
  description = "Program for data external"
  default = "echo '{\"result\": \"test\"}'"
}

variable "program_for_data_external2" {
  type = string
  description = "Program for data external"
  default = "'{\"result\": \"test2\"}'"
}

resource "terraform_data" "test" {
  count = var.res_count
  provisioner "local-exec" {
    command = var.command_for_local_exec
  }
}

resource "terraform_data" "always_recreated" {
  triggers_replace = timestamp()
}

variable "command_for_local_exec" {
  type = string
  description = "Command for local exec (single line; no newlines inside -c string)"
  default = "echo '{\"result\": \"test\"}'"
}

variable "data_count" {
  type = number
  description = "Number of data sources to create"
  default = 1
}

variable "res_count" {
  type = number
  description = "Number of resources to create"
  default = 1
}