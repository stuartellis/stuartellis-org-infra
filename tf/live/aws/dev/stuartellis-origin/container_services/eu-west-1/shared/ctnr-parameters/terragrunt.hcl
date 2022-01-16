include {
  path = find_in_parent_folders("root.hcl")
}

terraform {
  source = "../../../../../../../../../../stuartellis-org-tf-modules//aws/custom_ssm_parameters"
}

inputs = {
  namespace = "cntr/dev"
}
