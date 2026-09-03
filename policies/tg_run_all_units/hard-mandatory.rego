package terraform

import input.tfrun as tfrun

deny[reason] {
	path := tfrun.workspace.terragrunt.unit_path
	contains(path, "unit-hard")
	reason := sprintf("hard-mandatory: fail unit %v", [path])
}
