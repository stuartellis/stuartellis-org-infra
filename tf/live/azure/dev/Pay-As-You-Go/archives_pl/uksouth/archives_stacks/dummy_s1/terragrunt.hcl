include {
  path = find_in_parent_folders("root.hcl")
}

terraform {
  source = "../../../../../../../../../../stuartellis-org-tf-modules//azure/storage_archive"
}
