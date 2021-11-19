## stuart-ellis-origin

## Usage

Deploy the CloudFormation stacks.

KMS:

    aws cloudformation deploy --template-file $PWD/cfn-tf-kms-keys.yml --parameter-overrides Prefix=infra --stack-name infra-tf-kms

Replace *KMS-EXPORT* with *infra-tf-cmk-kms-key-arn*:

    aws cloudformation deploy --template-file $PWD/cfn-tf-storage.yml --parameter-overrides Prefix=infra å KmsKeyImport=KMS-EXPORT --stack-name infra-tf-storage

    aws cloudformation deploy --capabilities CAPABILITY_NAMED_IAM --template-file $PWD/cfn-tf-exec-role.yml --parameter-overrides Prefix=infra ManagedPolicyName=AdministratorAccess ManagingAccountID=119559809358 --stack-name infra-tf-exec

    aws cloudformation deploy --capabilities CAPABILITY_NAMED_IAM --template-file $PWD/cfn-tf-access-users.yml --parameter-overrides file://$PWD/cfn-tf-access-users.json --stack-name infra-tf-access
