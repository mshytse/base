version = "v1"

policy "metadata" {
    enabled = true
    enforcement_level = "advisory"
}

policy "advisory" {
  enabled           = true
  enforcement_level = "advisory"
}

policy "soft-mandatory" {
  enabled           = true
  enforcement_level = "soft-mandatory"
}

policy "hard-mandatory" {
  enabled           = true
  enforcement_level = "hard-mandatory"
}