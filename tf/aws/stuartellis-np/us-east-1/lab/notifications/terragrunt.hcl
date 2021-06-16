include {
  path = find_in_parent_folders("root.hcl")
}

terraform {
  source = "git::git@github.com:stuartellis/stuartellis-org-tf-modules.git//aws/notifications?ref=develop"
}
