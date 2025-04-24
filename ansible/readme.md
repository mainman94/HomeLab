sudo apt update
sudo apt install pipx sshpass

pipx run --spec --include-deps ansible ansible-galaxy collection install community.general
pipx inject --include-apps ansible argcomplete
pipx ensurepath

ssh-keygen
ssh-copy-id 192.168.0.147

cd /mnt/c/Users/phaup/work/HomeLab/ansible/proxmox-templates

ANSIBLE_CONFIG=./ansible.cfg ansible-playbook -i inventory/hosts playbook.yml