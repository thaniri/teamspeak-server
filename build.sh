#!/bin/bash
set -xe
# Make a directory for temporary files
mkdir -p ./tempFiles
ssh-keygen -t rsa -b 4096 -C "" -f ./tempFiles/id_teamspeak -N ""

# Provision EC2 instance
terraform apply -auto-approve

# Generate inventory for Ansible
echo "[teamspeak_server]" > ./tempFiles/inventory.yml
jq '.modules[0].resources."aws_instance.teamspeak_server".primary.attributes.public_ip' terraform.tfstate -r >> ./tempFiles/inventory.yml

# Wait a bit in case the server is slow to boot
echo "waiting"
sleep 15

# Install teamspeak
# flags:
# use autogenerated inventory and autogenerated ssh key
# use the ubuntu user
# use the python3 interpreter
# gain sudo privileges
# ignore ECDSA key checking
ansible-playbook -i ./tempFiles/inventory.yml ansible-playbook.yml --key-file ./tempFiles/id_teamspeak -u ubuntu -e 'ansible_python_interpreter=/usr/bin/python3' --become --ssh-common-args='-o StrictHostKeyChecking=no'
