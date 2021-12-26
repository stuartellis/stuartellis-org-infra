include {
  path = find_in_parent_folders("root.hcl")
}

terraform {
  source = "git::git@github.com:stuartellis/stuartellis-org-tf-modules.git//aws/sns_topic?ref=develop"
}

inputs = {
  full_topic_name = "stuartellis-origin-aaa-alerts"
  short_topic_name = "sje-ogn-a"
}
