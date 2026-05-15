terraform {
  required_providers {
    http = {
      source  = "hashicorp/http"
      version = "~> 3.4"
    }
  }
}

data "http" "example" {
  url = "https://example.com"
}

output "status_code" {
  value = data.http.example.status_code
}
