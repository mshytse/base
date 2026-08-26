package marker

group_marker = "group-advisory-fail"

# Called as a function on purpose: if this file is missing, OPA fails to compile
# with "undefined function" instead of silently leaving the rule undefined.
is_group(x) {
	x == group_marker
}
