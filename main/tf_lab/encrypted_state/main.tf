terraform {
  encryption {
    key_provider "pbkdf2" "passphrase" {
      passphrase = var.encryption_passphrase
    }

    method "aes_gcm" "default" {
      keys = key_provider.pbkdf2.passphrase
    }

    state {
      method = method.aes_gcm.default
    }
  }
}

variable "encryption_passphrase" {
  type      = string
  sensitive = true
}

resource "null_resource" "test" {}
