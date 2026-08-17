resource "random_pet" "seed" {
  length = 2

  keepers = {
    seed_tag = var.seed_tag
    env_name = var.env_name
  }
}

resource "terraform_data" "seed" {
  input = {
    pet      = random_pet.seed.id
    seed_tag = var.seed_tag
    env_name = var.env_name
    labels   = var.labels
  }
}
