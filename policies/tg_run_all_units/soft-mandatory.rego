package terraform

import input.tfrun as tfrun

deny[reason] {
	path := tfrun.workspace.terragrunt.unit_path
	contains(path, "unit-soft")
	reason := sprintf("soft-mandatory: fail unit %v", [path])
}
