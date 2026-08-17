data "external" "example" {
  program = ["python3", "-c", "import time, json; time.sleep(30); print(json.dumps({}))"]
  count   = 5
}
resource "null_resource" "to_generate_diff" {
  depends_on = [data.external.example]
}