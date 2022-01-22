# Ansible Playbooks

To run the Ansible playbook:

    ansible-playbook --connection=local ./ansible/tf-exec-role.yml --extra-vars "managing_account_id=119559809358 namespace=stuartellis-org stack_prefix=tf-exec"
