include {
  path = find_in_parent_folders("root.hcl")
}

terraform {
  source = "../../../../../../../../../../stuartellis-org-tf-modules//azure/resource_group"
}

inputs {
  name = "exp-rg"
  location = "uksouth"
}
