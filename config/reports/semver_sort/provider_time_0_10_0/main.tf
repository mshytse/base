terraform {
  required_providers {
    time = {
      source  = "hashicorp/time"
      version = "0.10.0"
    }
  }
}

resource "time_static" "this" {}

output "provider_version" {
  value = "0.10.0"
}
