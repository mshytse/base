terraform {
  required_providers {
    scalr = {
      source = "Scalr/scalr"
    }
  }
}

data "scalr_current_run" "this" {}

# Carries the run ID into the plan JSON so OPA policies can read it from
# tfplan.resource_changes. Also guarantees the plan always has a change,
# so the policy phase runs on every queue.
resource "terraform_data" "run_marker" {
  input = data.scalr_current_run.this.id
}
