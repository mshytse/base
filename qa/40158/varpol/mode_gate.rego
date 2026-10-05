package terraform

import input.tfplan as tfplan

deny["VAR-FAIL: mode is fail"] {
  tfplan.variables.mode.value == "fail"
}
