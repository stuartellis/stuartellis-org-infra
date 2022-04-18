include {
  path = find_in_parent_folders("root.hcl")
}

terraform {
  source = "../../../../../../../../../../stuartellis-org-tf-modules//aws/sns_standard_topics"
}

inputs = {
  namespace = "sje"
}
