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

resource "terraform_data" "fox" {
  input = "The quick brown fox jumps over the lazy dog"
}

resource "terraform_data" "owl" {
  input = "A wise old owl sat in an oak"
}

resource "terraform_data" "penguin" {
  input = "Emperor penguins huddle together for warmth in Antarctica"
}

resource "terraform_data" "capybara" {
  input = "The capybara is the world's largest rodent and loves swimming"
}

output "fox_fact" {
  value = terraform_data.fox.output
}

output "owl_fact" {
  value = terraform_data.owl.output
}

output "penguin_fact" {
  value = terraform_data.penguin.output
}

output "capybara_fact" {
  value = terraform_data.capybara.output
}