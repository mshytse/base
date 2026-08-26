# Always fails at hard-mandatory level.
# The message prints the marker this group loaded, so a cross-group common function
# leak is visible in the policy result.

package terraform

import data.marker

# Run ID, taken from the terraform_data.run_marker resource in the workspace config.
default run_id = "no-run-marker"

run_id = id {
	some i
	rc := input.tfplan.resource_changes[i]
	rc.type == "terraform_data"
	rc.name == "run_marker"
	id := rc.change.after.input
}

deny[msg] {
	marker.is_group("group-hard-pass")
	ns := time.now_ns()
	d := time.date(ns)
	c := time.clock(ns)
	msg := sprintf(
		"hard fail | marker=%s | run=%s | %04d-%02d-%02d %02d:%02d:%02d UTC",
		[
			marker.group_marker,
			run_id,
			d[0], d[1], d[2],
			c[0], c[1], c[2],
		],
	)
}
