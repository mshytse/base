package terraform

import input.tfplan as tfplan

deny["VAR-FAIL: mode is fail"] {
  tfplan.variables.mode.value == "fail"
}
# PR copy, same rule
# push 20:46:59
