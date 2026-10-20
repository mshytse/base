package terraform
import input.tfrun as tfrun

deny[reason] {
    not startswith(tfrun.workspace.name, "edge-")
    reason := sprintf("Workspace %s must be named with a team prefix (edge-*)", [tfrun.workspace.name])
}