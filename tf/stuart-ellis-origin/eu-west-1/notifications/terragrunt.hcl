include {
  path = find_in_parent_folders()
}

terraform {
  source = "git::git@github.com:stuartellis/stuart-ellis-org-tf-modules.git//aws/notifications?ref=develop"
}
