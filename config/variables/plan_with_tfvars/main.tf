terraform {
  required_providers {
    random = {
      source  = "hashicorp/random"
      version = "~> 3.0"
    }
  }
}

variable "pet_length" {
  type        = number
  description = "Number of words in the random pet name"
}

variable "pet_prefix" {
  type        = string
  description = "Prefix for the random pet name"
}

variable "input_value" {
  type        = string
  description = "Arbitrary string stored in terraform_data"
}

resource "random_pet" "name" {
  length = var.pet_length
  prefix = var.pet_prefix
}

resource "terraform_data" "example" {
  input = var.input_value
}

resource "null_resource" "example" {
  triggers = {
    pet_name = random_pet.name.id
  }
}

output "pet_name" {
  value = random_pet.name.id
}

output "stored_input" {
  value = terraform_data.example.output
}
