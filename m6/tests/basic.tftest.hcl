run "basic" {
  command = plan
  assert {
    condition     = var.a == "a-default"
    error_message = "bad"
  }
}
