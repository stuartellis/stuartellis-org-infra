## stuart-ellis-origin

## Usage

Deploy the CloudFormation stacks.

### Administrative Account

KMS:

    aws cloudformation deploy --template-file $PWD/cfn-tf-kms-keys.yml --parameter-overrides Prefix=infra --stack-name infra-tf-kms

Replace *KMS-EXPORT* with *infra-tf-cmk-kms-key-arn*:

    aws cloudformation deploy --template-file $PWD/cloudformation/stuartellis-origin/cfn-tf-storage.yml --parameter-overrides Prefix=infra KmsKeyImport=KMS-EXPORT --stack-name infra-tf-storage

IAM role for Terraform:

    aws cloudformation deploy --capabilities CAPABILITY_NAMED_IAM --template-file $PWD/cloudformation/stuartellis-origin/cfn-tf-exec-role.yml --parameter-overrides Prefix=infra ManagedPolicyName=AdministratorAccess ManagingAccountID=119559809358 --stack-name infra-tf-exec --region us-east-1

IAM user for Terraform:

    aws cloudformation deploy --capabilities CAPABILITY_NAMED_IAM --template-file $PWD/cloudformation/stuartellis-origin/cfn-tf-access-users.yml --parameter-overrides file://$PWD/cfn-tf-access-users.json --stack-name infra-tf-access --region us-east-1
