include {
  path = find_in_parent_folders("root.hcl")
}

terraform {
  source = "../../../../../../../../../../stuartellis-org-tf-modules//azure/vnet_minimal"
}

inputs = {
  name     = "exp-vnet-0010"
  location = "uksouth"
}
