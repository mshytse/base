terraform {
  required_providers {
    time = {
      source  = "hashicorp/time"
      version = "0.9.0"
    }
  }
}

# SCALRCORE-39212: lex puts 0.9.0 after 0.10.0; semver puts it first.
resource "time_static" "this" {}

output "provider_version" {
  value = "0.9.0"
}
