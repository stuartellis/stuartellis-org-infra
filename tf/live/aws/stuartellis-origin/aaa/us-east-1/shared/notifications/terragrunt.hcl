include {
  path = find_in_parent_folders("root.hcl")
}

terraform {
  source = "../../../../../../../../../stuartellis-org-tf-modules//aws/sns_topic"
}

inputs = {
  full_topic_name = "stuartellis-origin-aaa-alerts"
  short_topic_name = "sje-ogn-a"
}
