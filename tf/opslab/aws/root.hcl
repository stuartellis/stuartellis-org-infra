# root.hcl
locals {
  root_deployments_dir       = get_parent_terragrunt_dir()
  relative_deployment_path   = path_relative_to_include()
  deployment_path_components = compact(split("/", local.relative_deployment_path))

  # Get a list of every path between root_deployments_directory and the path of
  # the deployment
  possible_config_dirs = [
    for i in range(0, length(local.deployment_path_components) + 1) :
    join("/", concat(
      [local.root_deployments_dir],
      slice(local.deployment_path_components, 0, i)
    ))
  ]

  # Generate a list of possible config files at every possible_config_dir
  # (support both .yml and .yaml)
  possible_config_paths = flatten([
    for dir in local.possible_config_dirs : [
      "${dir}/config.yml",
      "${dir}/config.yaml"
    ]
  ])

  # Load every YAML config file that exists into an HCL object
  file_configs = [
    for path in local.possible_config_paths :
    yamldecode(file(path)) if fileexists(path)
  ]

  # Merge the objects together, with deeper configs overriding higher configs
  merged_config = merge(local.file_configs...)
}

# Pass the merged config to terraform as variable values using TF_VAR_
# environment variables
inputs = local.merged_config

remote_state {
  backend = "s3"
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }

  config = {
    bucket         = "infra-tfstate-eu-west-1"
    key            = "aws/${path_relative_to_include()}/terraform.tfstate"
    region         = "eu-west-1"
    encrypt        = true
    role_arn       = "arn:aws:iam::119559809358:role/infra-tf-exec"
    dynamodb_table = "infra-tfstate-lock-eu-west-1"
  }
}

generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
provider "aws" {
    region = "${local.merged_config.aws_region}"
    allowed_account_ids = ["${local.merged_config.aws_account_id}"]
    assume_role {
      role_arn = "${local.merged_config.aws_iam_role}"
      session_name = "tg-${local.merged_config.aws_account_id}"
    }
}
EOF
}
