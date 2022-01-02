include {
  path = find_in_parent_folders("root.hcl")
}

terraform {
  source = "../../../../../../../../../../stuartellis-org-tf-modules//aws/shared_ssm_parameters"
}

inputs = {
  namespace = "monitoring/opslab"
}
