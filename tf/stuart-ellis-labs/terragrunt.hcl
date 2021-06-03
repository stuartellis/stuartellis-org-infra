include {
  path = find_in_parent_folders()
}

terraform {
  source = "git@github.com:stuartellis/stuart-ellis-org-tf-modules.git//notifications?ref=develop"
}
