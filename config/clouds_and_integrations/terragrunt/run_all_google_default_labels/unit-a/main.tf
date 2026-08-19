terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 4.0"
    }
  }
}

resource "google_storage_bucket" "unit" {
  name          = "scalr-manual-run-all-labels-unit-a"
  location      = "US"
  force_destroy = true
}
