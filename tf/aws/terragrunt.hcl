locals {
  # Automatically load account-level variables
  account_vars = read_terragrunt_config(find_in_parent_folders("account.hcl"))

  # Automatically load region-level variables
  region_vars = read_terragrunt_config(find_in_parent_folders("region.hcl"))

  # Extract the variables we need for easy access
  aws_account_name = local.account_vars.locals.aws_account_name
  aws_account_id   = local.account_vars.locals.aws_account_id
  aws_iam_role = local.account_vars.locals.aws_iam_role
  aws_region   = local.region_vars.locals.aws_region
}

remote_state {
  backend = "s3"
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }

  config = {
    bucket         = "stuartellis-longhouse-dev-tfstate-eu-west-1"
    key            = "${path_relative_to_include()}/terraform.tfstate"
    region         = "eu-west-1"
    encrypt        = true
    role_arn       = "arn:aws:iam::119559809358:role/stuartellis-longhouse-dev-tf-exec"
    dynamodb_table = "stuartellis-longhouse-dev-tfstate-lock-eu-west-1"
  }
}

generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
provider "aws" {
    region = "${local.aws_region}"
    allowed_account_ids = ["${local.aws_account_id}"]
    assume_role {
      role_arn = "${local.aws_iam_role}"
      session_name = "tg-${local.aws_account_id}"
    }
}
EOF
}

inputs = merge(
  local.account_vars.locals,
  local.region_vars.locals,
)
