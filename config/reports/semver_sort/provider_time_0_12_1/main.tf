terraform {
  required_providers {
    time = {
      source  = "hashicorp/time"
      version = "0.12.1"
    }
  }
}

resource "time_static" "this" {}

output "provider_version" {
  value = "0.12.1"
}
