data "external" "test" {
  program = ["bash", "-c", var.program_for_data_external]
}

variable "program_for_data_external" {
  type = string
  description = "Program for data external"
  default = "echo '{\"result\": \"test\"}'"
}

resource "terraform_data" "test" {
  count = var.data_count
  provisioner "local-exec" {
    command = var.command_for_local_exec
  }
}

resource "terraform_data" "always_recreated" {
  count = var.res_count
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