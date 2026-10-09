version = "v1"

policy "../enforce_alb_https" {
  enabled           = true
  enforcement_level = "advisory"
}

policy "../enforce_tls_policy" {
  enabled           = true
  enforcement_level = "advisory"
}

