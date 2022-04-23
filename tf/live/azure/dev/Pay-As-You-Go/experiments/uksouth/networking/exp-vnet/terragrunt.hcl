include {
  path = find_in_parent_folders("root.hcl")
}

terraform {
  source = "../../../../../../../../../../stuartellis-org-tf-modules//azure/resource_group"
}

inputs = {
  name = "exp-vnet-0010"
  location = "uksouth"
}
