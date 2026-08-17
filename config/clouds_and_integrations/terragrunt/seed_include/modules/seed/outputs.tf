output "pet_name" {
  value       = random_pet.seed.id
  description = "Random pet name produced by the seed module"
}

output "seed" {
  value = {
    pet      = random_pet.seed.id
    seed_tag = var.seed_tag
    env_name = var.env_name
    labels   = var.labels
  }
  description = "Full seed payload from Terragrunt inputs"
}
