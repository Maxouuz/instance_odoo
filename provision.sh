#!/bin/bash

#Connexion à Azure 
az account show || az login

#On se rend dans le dossier terraform
cd /home/maxence/Documents/school/sae6/terraform

#On déploie l'infra avec Terraform
terraform init
terraform plan
terraform apply
terraform apply #Nécéssaire pour attribution des ip dans le output.tf

#On se rend dans le répertoire ansible
cd /home/maxence/Documents/school/sae6/ansible

#Eris le hosts.ini
echo "Création du hosts.ini"
ansible-playbook -i /home/maxence/Documents/school/sae6/ansible/hosts.ini -u dieu -k /home/maxence/Documents/school/sae6/ansible/provisionning/1-playbook_host.yml

# On installe la collection qui vous servira à postgres
ansible-galaxy collection install community.postgresql

# Lance playbook install applications - 2
echo "Lancement du playbook install applications - 2"
ansible-playbook -i /home/maxence/Documents/school/sae6/ansible/hosts.ini /home/maxence/Documents/school/sae6/ansible/provisionning/2-playbook_install_ngnix.yml

# Lance playbook install applications - 3
echo "Lancement du playbook install applications - 3"
ansible-playbook -i /home/maxence/Documents/school/sae6/ansible/hosts.ini /home/maxence/Documents/school/sae6/ansible/provisionning/3-playbook_install_psql.yml

# Lance playbook install applications - 4
echo "Lancement du playbook install applications - 4"
ansible-playbook -i /home/maxence/Documents/school/sae6/ansible/hosts.ini /home/maxence/Documents/school/sae6/ansible/provisionning/4-playbook_install_docker.yml
