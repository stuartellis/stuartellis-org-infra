# Ansible Playbooks

To run the Ansible playbook for Terraform execution role:

    ansible-playbook --connection=local ./ansible/deploy-tf-exec-role.yml --extra-vars "managing_account_id=119559809358 org_namespace=stuartellis-org stack_prefix=tf-exec"

To run the Ansible playbook for Terraform storage:

    ansible-playbook --connection=local ./ansible/deploy-tf-storage-playbook.yml --extra-vars "org_namespace=stuartellis-org stack_prefix=tf-state primary_region=eu-west-2 secondary_region=eu-west-1"

To run the Ansible playbook for Terraform access for CI automation:

    ansible-playbook --connection=local ./ansible/deploy-tf-access-identity.yml --extra-vars "org_namespace=stuartellis-org stack_prefix=tf-access-ci kms_key_arn=arn:aws:kms:eu-west-2:119559809358:key/d6120c4e-9d2d-483a-af29-9a12e43ed4ae s3_bucket_arn=arn:aws:s3:::tf-state-source-119559809358-eu-west-2 ddb_table_arn=arn:aws:dynamodb:eu-west-1:119559809358:table/infra-tfstate-lock-eu-west-1 same_account_exec_role=arn:aws:iam::119559809358:role/stuartellis-org-tf-exec-role account_0001_exec_role=arn:aws:iam::333594256635:role/infra-tf-exec"
