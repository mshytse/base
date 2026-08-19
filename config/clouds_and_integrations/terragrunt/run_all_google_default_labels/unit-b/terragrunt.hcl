include "root" {
  path = find_in_parent_folders("root.hcl")
}

# unit-a is outside unit-b WD; only planned with include-external-dependencies.
dependencies {
  paths = ["../unit-a"]
}
