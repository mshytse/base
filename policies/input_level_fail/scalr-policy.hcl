version = "v1"

policy "advisory" {
  enabled           = true
  enforcement_level = "advisory"
}

policy "soft-mandatory" {
  enabled           = true
  enforcement_level = "soft-mandatory"
}

policy "hard-mandatory" {
  enabled           = false
  enforcement_level = "hard-mandatory"
}
