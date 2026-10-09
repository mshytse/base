version = "v1"

policy "../../top" {
  enabled           = true
  enforcement_level = "advisory"
}

policy "sub/inner" {
  enabled           = true
  enforcement_level = "advisory"
}

policy "suffixed.rego" {
  enabled           = true
  enforcement_level = "advisory"
}

