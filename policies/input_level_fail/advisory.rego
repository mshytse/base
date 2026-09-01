package terraform

import input.tfplan as tfplan

deny[reason] {
	val := sprintf("%v", [tfplan.variables.input.value])
	contains(val, "advisory")
	reason := sprintf("advisory: var.input contains 'advisory' (%v)", [tfplan.variables.input.value])
}
