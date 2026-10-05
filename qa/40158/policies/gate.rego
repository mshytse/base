package terraform

import data.simple_rules

# SCALRCORE-40158 base: never denies.
deny["BASE-POLICY-DENY"] {
  simple_rules.is_false(true)
}
# pr 14
