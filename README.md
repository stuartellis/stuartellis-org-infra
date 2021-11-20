# stuartellis-org-infra

Automation for stuartellis.org environments.

This uses [Terraform](https://www.terraform.io/) and [Terragrunt](https://terragrunt.gruntwork.io).

## Setup

In the origin account, first use CloudFormation to set up the backend:

- cfn-tf-kms-keys.yml
- cfn-tf-kms-storage.yml

Then use CloudFormation to add the user account for Terraform:

- cfn-tf-access-users.yml

In the managed account, use CloudFormation to deploy a role:

- cfn-tf-exec-role.yml

## Usage

To apply the Terraform code for a region in an account:

    cd tf/aws/stuartellis-np/eu-west-1
    terragrunt run-all plan --terragrunt-source-update
    terragrunt run-all apply 

## How This Works

Each stack includes a *terragrunt.hcl* configuration file.

The configuration file specifies the module that the stack uses, and includes the *root.hcl* file. The *root.hcl* file reads all *config.yml* and *config.yaml* files, and merges their contents into a single *merged_config* object.

Use *local.merged_config* to reference variables from the *merged_config*:

    local.merged_config.aws_region

The *root.hcl* also specifies the configuration for the Terraform backend.

> The code is adapted from [this post](https://thirstydeveloper.io/2021/01/17/part-1-organizing-terragrunt.html).
