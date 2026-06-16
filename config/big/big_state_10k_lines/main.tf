# Each terraform_data instance with this input structure produces 95 lines in the
# state JSON (index_key + schema_version + id + input{value+type} + output{value+type}
# + triggers_replace{value+type} + sensitive_attributes).
#
# 150 instances × 95 lines + ~30 lines overhead ≈ 14 280 lines total.
#
# terraform_data is a built-in provider; all 150 instances apply near-instantly.
#
# No backend block — use the Scalr-managed backend or any workspace backend.
# The bug affected all backends, so this works with either.
#
# After apply:
#   - resources_count on the workspace should be 150
#   - no "Failed to parse state" in worker logs
#   - confirm the state really is large: terraform state pull | wc -l (expect > 10 000)

variable "config" {
  default = {
    enabled     = true
    max_retries = 3
    name        = "worker"
  }
  type = object({
    enabled     = bool
    max_retries = number
    name        = string
  })
}

variable "environment" {
  default = "dev"
  type    = string
}

variable "tags" {
  default = {
    cost_center = "eng"
    owner       = "platform"
    project     = "my-app"
  }
  type = map(string)
}

resource "terraform_data" "state_padding" {
  count = 150

  input = {
    config = {
      enabled     = var.config.enabled
      max_retries = var.config.max_retries
      name        = "${var.config.name}-${count.index}"
    }
    enable_monitoring = count.index % 2 == 0
    environment       = var.environment
    instance_count    = count.index * 2
    tags              = var.tags
  }

  triggers_replace = {
    config_name = "${var.config.name}-${count.index}"
    environment = var.environment
  }
}

output "total_instances" {
  value = length(terraform_data.state_padding)
}
