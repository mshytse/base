variable "bucket_path_prefix" {
  type = string
  description = "The path prefix to store states in"
}

variable "state_bucket_name" {
  type = string
  description = "The name of bucket to store states in"
  default = "state_storage_mshytse"
}

data "scalr_current_run" "get_ws_name" {}

resource "terraform_data" "single" {
  triggers_replace = timestamp()
}

resource "terraform_data" "multiple" {
  input = {
    project_name = var.mock_project_name
    environment  = var.mock_environment
    timestamp    = timestamp()
    random_value = random_string.suffix.result
  }
}

resource "random_string" "suffix" {
  length  = 4
  special = false
  upper   = false
}

variable "mock_project_name" {
  type = string
  default = "mock_project_name"
}

variable "mock_environment" {
  type = string
  default = "mock_environment"
}

output "workspace_name" {
  value = data.scalr_current_run.get_ws_name.workspace_name
}

output "environment_id" {
  value = data.scalr_current_run.get_ws_name.environment_id
}

output "random_suffix" {
  value = random_string.suffix.result
}

output "gcs_state_path" {
  value = "${var.state_bucket_name}/${var.bucket_path_prefix}"
}