variable "vcs_provider_id" {
  type        = string
  description = "Scalr VCS provider ID (vcs-...)."
}

variable "vcs_repo_identifier" {
  type        = string
  description = "VCS repo in org/repo form."
  default     = "mshytse/base"
}

variable "vcs_branch" {
  type        = string
  description = "Branch for all fixture workspaces."
  default     = "master"
}

variable "name_prefix" {
  type        = string
  description = "Prefix for workspace names: <prefix>-<fixture_dir>."
  default     = "semver-sort"
}

variable "auto_queue_runs" {
  type        = string
  description = "Workspace auto_queue_runs: skip_first | always | never | on_create_only."
  default     = "never"
}

variable "aws_provider_configuration_id" {
  type        = string
  description = "Optional AWS pcfg-... attached only to provider_aws_* workspaces."
  default     = null
}
