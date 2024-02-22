#!/bin/bash

hosts_file="/home/maxence/Documents/school/sae6/ansible/hosts.ini"
save_sql_dir="/home/maxence/Documents/school/sae6/save_sql/"

# Demander à l'utilisateur le nombre d'instances à ajouter
read -p "Combien d'instances voulez-vous ajouter ? " num_instances

# Variable pour stocker les nouvelles instances
new_instances=""

# Boucle pour ajouter les nouvelles instances
for ((i=1; i<=$num_instances; i++))
do
    # saisis des données
    read -p "Entrez le nom de l'instance: " instance_name
    read -p "Entrez le port1: " port1
    read -p "Entrez le port2: " port2

    #crée le dossier de save correspondant au nom de l'instance
    mkdir -p "$save_sql_dir/$instance_name"

    # concatnènes
    new_instance="$instance_name $port1 $port2"

    # Ajouter la nouvelle instance à la liste des instances
    if [ -z "$new_instances" ]; then
        new_instances="\"$new_instance\""
    else
        new_instances+=", \"$new_instance\""
    fi
done

# Si la ligne 'instances=' existe déjà, alors ajouter les nouvelles instances à la suite
if grep -q '^instances=' "$hosts_file"; then
    sed -i "s/instances=\[/instances=[$new_instances, /" "$hosts_file"
else
    # Sinon, ajouter une nouvelle ligne 'instances=' à la fin du fichier
    echo "instances=[$new_instances]" >> "$hosts_file"
fi

echo "Nouvelles instances ajoutées avec succès."


#-------------

#Exécution des playbooks de déploiement

echo "Lancement du playbook déploiement - 1"
ansible-playbook -i /home/maxence/Documents/school/sae6/ansible/hosts.ini /home/maxence/Documents/school/sae6/ansible/instance/1-playbook_ins_nginx.yml

echo "Lancement du playbook déploiement - 2"
ansible-playbook -i /home/maxence/Documents/school/sae6/ansible/hosts.ini /home/maxence/Documents/school/sae6/ansible/instance/2-playbook_ins_psql.yml

echo "Lancement du playbook déploiement - 3"
ansible-playbook -i /home/maxence/Documents/school/sae6/ansible/hosts.ini /home/maxence/Documents/school/sae6/ansible/instance/3-playbook_ins_odoo.yml