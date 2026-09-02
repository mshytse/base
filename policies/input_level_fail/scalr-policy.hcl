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
  enabled           = true
  enforcement_level = "hard-mandatory"
}

policy "sleep_5" {
  enabled           = true
  enforcement_level = "advisory"
}

policy "sleep_10" {
  enabled           = true
  enforcement_level = "advisory"
}

policy "sleep_15" {
  enabled           = true
  enforcement_level = "soft-mandatory"
}

policy "sleep_20" {
  enabled           = true
  enforcement_level = "soft-mandatory"
}
