variable "seed_tag" {
  type        = string
  description = "Stable label for leftover seed identity"
}

variable "env_name" {
  type        = string
  description = "Short environment name from Terragrunt locals"
}

variable "labels" {
  type        = map(string)
  description = "Extra labels passed via Terragrunt inputs"
  default     = {}
}
