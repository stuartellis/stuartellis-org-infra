include {
  path = find_in_parent_folders("root.hcl")
}

terraform {
  source = "../../../../../../../../../../stuartellis-org-tf-modules//aws/cw_billing_monitoring"
}
