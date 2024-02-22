# Projet deploiement Odoo Semestre 6 BUT Informatique

## KOZAN Jade - STIEVENARD Maxence

Nous avons décidé de donner l'arobresence ci-dessus à notre projet : 

```tree
.
├── ansible
│   ├── hosts.ini
│   ├── instance
│   │   ├── 1-playbook_ins_nginx.yml
│   │   ├── 2-playbook_ins_psql.yml
│   │   └── 3-playbook_ins_odoo.yml
│   ├── provisionning
│   │   ├── 1-playbook_host.yml
│   │   ├── 2-playbook_install_ngnix.yml
│   │   ├── 3-playbook_install_psql.yml
│   │   └── 4-playbook_install_docker.yml
│   └── save
│       ├── 1-playbook_dump.yml
│       └── 2-playbook_restore.yml
├── destroy.sh
├── doc
│   ├── deploiement
│   │   └── deploiement.md
│   ├── infra
│   │   └── infra.md
│   ├── main.md
│   └── save
│       └── save.md
├── dump.sh
├── instance.sh
├── provision.sh
├── README.md
├── restore.sh
├── save_sql
├── terraform
│   ├── database.tf
│   ├── networks.tf
│   ├── odoo.tf
│   ├── output.tf
│   ├── provider.tf
│   ├── ressource_group.tf
│   ├── reverse_proxy.tf
│   ├── security_group.tf
│   ├── .terraform
│   │   └── providers
│   │       └── registry.terraform.io
│   │           └── hashicorp
│   │               └── azurerm
│   │                   └── 3.92.0
│   │                       └── linux_amd64
│   │                           └── terraform-provider-azurerm_v3.92.0_x5
│   ├── .terraform.lock.hcl
│   ├── terraform.tfstate
│   ├── terraform.tfstate.backup
│   └── variables.tf
└── terraform.tfstate

17 directories, 34 files
```

- Nous documenterons dans un premier temps la partie **infrastructure** effectuée avec **Terraform** situéé à [**ce lien**](../doc/infra/infra.md)
- Puis dans un deuxième temps nous verrons la partie **déploiement** située à [**ce lien**](../doc/deploiement/deploiement.md).
- Et nous finirons par la partie **sauvegarde** située à [**ce lien**](../doc/save/save.md)

## Lancement du projet 

### Création de l'infrastructure et provisionnement des machines. 

```bash
chmod u+x provision.sh
./provision.sh
```

### Déploiement d'instances

```bash
chmod u+x instance.sh
./instance.sh
```

### Backup 

#### Dump des bases de données

```bash
chmod u+x dump.sh
./dump.sh
```

#### Restore des saves

```bash
chmod u+x restore.sh
./restore.sh
```