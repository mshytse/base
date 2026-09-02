package terraform

import input.tfplan as tfplan

deny[reason] {
	val := sprintf("%v", [tfplan.variables.input.value])
	contains(val, "soft-mandatory")
	reason := sprintf("TBD!!! (%v)", [tfplan.variables.input.value])
}
