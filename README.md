# stuart-ellis-org-infra

Automation for stuartellis.org environments.

This uses [Terraform](https://www.terraform.io/) and [Terragrunt](https://terragrunt.gruntwork.io).

## Setup

In the origin account, first use CloudFormation to set up the backend:

- cfn-tf-kms-keys.yaml
- cfn-tf-kms-backend.yaml

Then use CloudFormation to add the user account for Terraform:

- cfn-tf-access-users.yaml

In the managed account, use CloudFormation to deploy a role:

- cfn-tf-exec-role.yaml

## Usage

To apply the Terraform code for a region in an account:

    cd tf/stuart-ellis-origin/eu-west-1
    terragrunt run-all plan --terragrunt-source-update 
    terragrunt run-all apply 
