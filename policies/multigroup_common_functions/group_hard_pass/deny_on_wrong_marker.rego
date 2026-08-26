# Passes only when this group got its own functions/marker.rego.
# Denies if the other group's common function of the same file name leaked in.

package terraform

import rego.v1
import data.marker

deny contains msg if {
	marker.group_marker != "group-hard-pass"
	msg := sprintf("Wrong common function loaded: got marker %q", [marker.group_marker])
}
