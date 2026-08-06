version = "v1"

policy "metadata" {
    enabled = true
    enforcement_level = "advisory"
}


policy "hard-mandatory" {
  enabled           = true
  enforcement_level = "hard-mandatory"
}
