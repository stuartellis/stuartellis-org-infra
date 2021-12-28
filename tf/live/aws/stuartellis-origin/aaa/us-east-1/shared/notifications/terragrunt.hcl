include {
  path = find_in_parent_folders("root.hcl")
}

terraform {
  source = "git::https://dev.azure.com/sjellis/sje-ado-labs/_git/stuartellis-org-tf-modules//aws/sns_topic?ref=develop"
}

inputs = {
  full_topic_name = "stuartellis-origin-aaa-alerts"
  short_topic_name = "sje-ogn-a"
}
