# Always fails at advisory level, so the run continues and both groups report a result.
# Firing on its own marker also proves this group got its own functions/marker.rego.

package terraform

import data.marker

deny[msg] {
	marker.is_group("group-advisory-fail")
	msg := "Advisory failure from group-advisory-fail"
}
