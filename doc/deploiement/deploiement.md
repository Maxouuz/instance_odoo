# Partie déploiement - Ansible

## Partie provisionning

Cette partie permet l'installation et la configuration des technologies que nous utilisons pour mener à bien ce projet.

Dans un premier lieu nous avons effectué un playbook nommé [**playbook-host.yml**](../../ansible/provisionning/1-playbook_host.yml) permettant, à l'aide des outputs de Terraform d'adresser les playbooks aux bons hosts. 

Nous retrouvons ensuite les playbooks suivants : 

- [**playbook_install_ngnix.yml**](../../ansible/provisioning/2-playbook_install_ngnix) : Installant simplement le service ngnix

- [**playbook_install_psql.yml**](../../ansible/provisioning/3-playbook_install_psql) : Installant la base de données postgres, ses dépendences et configure le fichier `pg_hba.conf`

- [**playbook_install_docker**](../../ansible/provisionning/4-playbook_install_docker.yml) : Installant docker sur la machine odoo et ses dépendences.


Cette partie s'éxécute automatiquement au lancement du script [**provision.sh**](../../provision.sh)


## Partie déploiement d'instances

Cette partie nous sert à automatiser le déploiement d'instances, Nous avons crées 3 playbooks automatisant respectivement le reverse proxxy, la base de donées et le conteneur docker d'odoo.

- [**playbook_ins_nginx.yml**](../../ansible/instance/1-playbook_ins_nginx.yml) : Ce playbook nous permet de créer un fichier avec la configuration du reverse proxy pour chaque instance déployée. Ce fichiée sera stockée sur la machine dans `/etc/nginx/sites-enabled/`. Il nous permet également d'ouvrir les ports sur lesquels les instances sont déployées. 

- [**playbook_ins_psql.yml**](../../ansible/instance/2-playbook_ins_psql.yml) : Ce playbook crée les utilisateurs et leurs donnes les permissions de la base de données de leurs absences. 

- [**playbook_ins_odoo.yml**](../../ansible/instance/3-playbook_ins_odoo.yml): Ce playbook crée un docker-compose et un fichier odoo.conf pour chaque instance dans le dossier `/root/instances` et lance les conteneurs à l'aide d'un docker compose up.


Cette partie s'éxécute avec le script [**instance.sh**](../../instance.sh) qui initialisera les instances dans le hosts.ini à l'ide d'un script et lancera les 3 playbooks. Il demandera le nombre d'instance voulu, et s'occupera automatiquement du reste. 





> Revenir [**au point de départ de la documentation**](../main.md)