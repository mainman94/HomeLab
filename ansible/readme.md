sudo apt update
sudo apt install pipx sshpass

pipx install --include-deps ansible
pipx install ansible-dev-tools
pipx inject ansible argcomplete
pipx ensurepath


ssh-keygen
ssh-copy-id 192.168.0.147

cd /mnt/c/Users/phaup/work/HomeLab/ansible/proxmox-templates

ANSIBLE_CONFIG=./ansible.cfg ansible-playbook -i inventory/hosts playbook.yml