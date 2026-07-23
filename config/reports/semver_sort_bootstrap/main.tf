terraform {
  required_providers {
    scalr = {
      source = "scalr/scalr"
    }
  }
}

data "scalr_current_run" "this" {}

locals {
  # Working dir under mshytse/base → config/reports/semver_sort/<key>
  # OpenTofu fixtures: iac_platform=opentofu + version from Scalr's OpenTofu list (>= 1.6.0).
  fixtures = {
    provider_time_0_9_0  = { iac_platform = "terraform", version = null }
    provider_time_0_10_0 = { iac_platform = "terraform", version = null }
    provider_time_0_11_2 = { iac_platform = "terraform", version = null }
    provider_time_0_12_1 = { iac_platform = "terraform", version = null }

    provider_aws_4_4_0  = { iac_platform = "terraform", version = null }
    provider_aws_4_32_0 = { iac_platform = "terraform", version = null }
    provider_aws_4_52_7 = { iac_platform = "terraform", version = null }

    module_label_0_9_0  = { iac_platform = "terraform", version = null }
    module_label_0_10_0 = { iac_platform = "terraform", version = null }
    module_label_0_11_0 = { iac_platform = "terraform", version = null }
    module_label_0_25_0 = { iac_platform = "terraform", version = null }

    tofu_1_6_0  = { iac_platform = "opentofu", version = "1.6.0" }
    tofu_1_7_2  = { iac_platform = "opentofu", version = "1.7.2" }
    tofu_1_9_0  = { iac_platform = "opentofu", version = "1.9.0" }
    tofu_1_10_5 = { iac_platform = "opentofu", version = "1.10.5" }
  }
}

resource "scalr_workspace" "fixture" {
  for_each = local.fixtures

  name            = "${var.name_prefix}-${each.key}"
  environment_id  = data.scalr_current_run.this.environment_id
  vcs_provider_id = var.vcs_provider_id

  working_directory           = "config/reports/semver_sort/${each.key}"
  iac_platform                = each.value.iac_platform
  terraform_version           = each.value.version
  auto_queue_runs             = var.auto_queue_runs
  deletion_protection_enabled = false
  type                        = "testing"

  vcs_repo {
    identifier = var.vcs_repo_identifier
    branch     = var.vcs_branch
  }

  dynamic "provider_configuration" {
    for_each = (
      startswith(each.key, "provider_aws_") && var.aws_provider_configuration_id != null
      ? [var.aws_provider_configuration_id]
      : []
    )
    content {
      id = provider_configuration.value
    }
  }
}
