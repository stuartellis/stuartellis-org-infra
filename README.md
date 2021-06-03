# stuart-ellis-org-infra

Automation for stuartellis.org environments.

This uses [Terraform](https://www.terraform.io/) and [Terragrunt](https://terragrunt.gruntwork.io).

## Usage

To apply all of the Terraform code:

    cd tf
    terragrunt run-all apply

To run the code for an environment:

    cd tf/stuart-ellis-labs
    terragrunt apply --terragrunt-source ../../../stuart-ellis-org-tf-modules//aws/notifications
