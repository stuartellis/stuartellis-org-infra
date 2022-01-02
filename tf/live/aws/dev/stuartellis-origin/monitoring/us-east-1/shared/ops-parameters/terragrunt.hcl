include {
  path = find_in_parent_folders("root.hcl")
}

terraform {
  source = "../../../../../../../../../../stuartellis-org-tf-modules//aws/shared_ssm_parameters"
}

inputs = {
  namespace = "${local.merged_config.productline}/${local.merged_config.environment}"
}
