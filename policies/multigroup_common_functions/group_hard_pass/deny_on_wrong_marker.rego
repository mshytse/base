# Passes only when this group got its own functions/marker.rego.
# Denies if the other group's common function of the same file name leaked in.

package terraform

import data.marker

deny[msg] {
	not marker.is_group("group-hard-pass")
	msg := sprintf("Wrong common function loaded: got marker %s", [marker.group_marker])
}
