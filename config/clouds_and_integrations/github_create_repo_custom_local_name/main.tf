# SCALRCORE-37576: provider local name differs from lock/source short name.
#
# Scalr setup:
#   1. Custom provider configuration with type/provider_name = "gh"
#      credentials: token = <GitHub PAT with repo create>, optional owner = <user/org>
#   2. Link that PCFG to the workspace
#   3. Do NOT set GITHUB_TOKEN / GITHUB_OWNER on the runner
#   4. Commit this file + .terraform.lock.hcl (run `terraform init` locally first)
#
# Expect: plan/apply succeeds only if Scalr injects provider "gh" override from PCFG.
# Lock file will register integrations/github as "github"; PCFG type is "gh".
#
# Terragrunt: see ../terragrunt/github_create_repo_custom_local_name/

terraform {
  required_providers {
    gh = {
      source  = "integrations/github"
      version = "~> 6.0"
    }
  }
}

variable "repository_name" {
  type        = string
  description = "GitHub repository name to create"
  default     = "tf-gh-pcfg-local-name-test-delete-me"
}

# Creds must come from Scalr PCFG override — no provider "gh" block here.

resource "github_repository" "test" {
  provider = gh

  name        = var.repository_name
  description = "SCALRCORE-37576: custom local name + Scalr PCFG override"
  visibility  = "private"
  auto_init   = true
}
