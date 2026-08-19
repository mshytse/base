include "root" {
  path = find_in_parent_folders("root.hcl")
}

# unit-a is outside unit-b WD; only planned with include-external-dependencies.
dependency "unit_a" {
  config_path = "../unit-a"

  mock_outputs = {
    bucket_name = "scalr-manual-run-all-labels-unit-a"
  }
}

inputs = {
  unit_name = "unit-b"
  upstream  = dependency.unit_a.outputs.bucket_name
}
