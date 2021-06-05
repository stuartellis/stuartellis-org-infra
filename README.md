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

To apply all of the Terraform code:

    cd tf
    terragrunt run-all apply

To run the code for an environment:

    cd tf/stuart-ellis-labs
    terragrunt apply --terragrunt-source ../../../stuart-ellis-org-tf-modules//aws/notifications
