output "environment_id" {
  value = data.scalr_current_run.this.environment_id
}

output "workspace_ids" {
  value = { for k, ws in scalr_workspace.fixture : k => ws.id }
}

output "workspace_names" {
  value = { for k, ws in scalr_workspace.fixture : k => ws.name }
}
