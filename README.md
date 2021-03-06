# stuartellis-org-infra

Automation for cloud environments.

This uses [Terraform](https://www.terraform.io/) and [Terragrunt](https://terragrunt.gruntwork.io).

## Directory Structure

### Top-Level

Top-level directories:

- .azure-pipelines
- cloudformation
- pipelines
- tf

### Infrastructure Definitions

The *tf* directories follow the same structure:

    zone/
        provider/
            environment/
                account/
                    product-line/
                        region/
                            product/

> Each *product-line* has a *global* region for resources that are not specific to a region.

For example:

    labs/aws/stuartellis-origin/monitoring/global/shared/

### Pipeline Definitions

The *pipelines* follow this structure:

    zone/
        product-line/
            provider/
              region/
                 product/

Each product-line has a pipeline per provider. The pipeline has one stage for each combination of region and environment. Each stage deploys specific stacks.

## Setup

In the origin account, first use CloudFormation to set up the backend. See *cloudformation/stuartellis-origin/README.md* for details.

In the managed accounts, use CloudFormation to deploy an IAM role for Terraform:

- cfn-tf-exec-role.yml

## Usage

Add the *bin/* directory for this project to your PATH.

To apply all of the Terraform code for a region in an environment:

    cd tf/live/aws/stuartellis-np/monitoring/us-east-1
    terragrunt run-all plan --terragrunt-source-update
    terragrunt run-all apply 

## How This Works

Each stack includes a *terragrunt.hcl* configuration file.

The configuration file specifies the module that the stack uses, and includes the *root.hcl* file. The *root.hcl* file reads all *config.yml* and *config.yml* files, and merges their contents into a single *merged_config* object.

Use *local.merged_config* to reference variables from the *merged_config*:

    local.merged_config.aws_region

The *root.hcl* also specifies the configuration for the Terraform backend.

> The code is adapted from [this post](https://thirstydeveloper.io/2021/01/17/part-1-organizing-terragrunt.html).
