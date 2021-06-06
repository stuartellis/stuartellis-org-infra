include {
  path = find_in_parent_folders("root.hcl")
}

terraform {
  source = "git::git@github.com:stuartellis/stuart-ellis-org-tf-modules.git//aws/billing_alerts?ref=develop"
}

dependency "notifications" {
  config_path = "../notifications"
}

inputs = {
  sns_alerts_arn = dependency.notifications.outputs.sns_alerts_arn
}
