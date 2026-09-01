package terraform

import input.tfplan as tfplan

deny[reason] {
	val := sprintf("%v", [tfplan.variables.input.value])
	contains(val, "soft-mandatory")
	reason := sprintf("!!! soft-mandatory: var.input contains 'soft-mandatory' (%v)", [tfplan.variables.input.value])
}
