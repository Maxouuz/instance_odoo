# Partie infrastructure - Terraform

Cette première partie s'effectue à l'aide le provider Azure.

Nous avons décomposés la partie infrastrucutre à l'aide de 9 fichiers : 

- [**provider.tf**](../../terraform/provider.tf) : Où l'on a simplement défini notre provider, ici Azure. 
- [**ressource_group.tf**](../../terraform/ressource_group.tf) : Contenant la définition de notre groupe de ressources, où toute notre infrastructure vas être réunie.
- [**variable.tf**](../../terraform/variable.tf) : Définissant toutes les variables utilisées dans les autres fichiers afin de faciliter l'écriture de ceux-ci.
- [**networks.tf**](../../terraform/networks.tf) : Définit le sous réseau qui sera utilsiée par les machines
- Les fichiers [**database.tf**](../../terraform/database.tf), [**odoo.tf**](../../terraform/odoo.tf) et [**reverse_proxy.tf**](../../terraform/reverse_proxy.tf) nous permettent de définir les **trois** machines qui seront utilisées pour le déploiment. On leur définit un système d'exploitation, une ip publique est ...
- [**security_group.tf**](../../terraform/security_group.tf) : Permet de définir les règles de sécurité et d'accès aux machines virtuelles.
- [**output.tf**](../../terraform/output.tf) : Fichier permettant stocker les addresse IP des machines, ce fichier nous sera extrêment utile lors de la liaison avec Ansible pour le déploiement.

Ces neufs fichiers définissent notre infrastrure et peuvent être déployé à l'aide du script [**provision.sh**](../../provision.sh)





> Revenir [**au point de départ de la documentation**](../main.md)