package terraform

import input.tfplan as tfplan

deny[reason] {
	val := sprintf("%v", [tfplan.variables.input.value])
	contains(val, "hard-mandatory")
	reason := sprintf("hard-mandatory: var.input contains 'hard-mandatory' (%v)", [tfplan.variables.input.value])
}
