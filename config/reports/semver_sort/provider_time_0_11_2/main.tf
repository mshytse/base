terraform {
  required_providers {
    time = {
      source  = "hashicorp/time"
      version = "0.11.2"
    }
  }
}

resource "time_static" "this" {}

output "provider_version" {
  value = "0.11.2"
}
