terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 4.0"
    }
  }
}

variable "unit_name" {
  type    = string
  default = "unit-b"
}

variable "upstream" {
  type    = string
  default = "none"
}

resource "google_storage_bucket" "unit" {
  name          = "scalr-manual-run-all-labels-${var.unit_name}"
  location      = "US"
  force_destroy = true

  labels = {
    app      = "bucket-test"
    upstream = var.upstream
  }
}
