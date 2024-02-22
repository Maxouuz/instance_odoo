variable "name" {
  description = "Nommage des ressources"
  default     = "odoo"
}

variable "location" {
  description = "Région de déploiement des ressources"
  default     = "France Central"
}

variable "short" {
  description = "Nom court de la région"
  default     = "frc"
}

variable "odoo_ip" {
  description = "Ip privé d'odoo"
  default = "10.0.8.100"
}

variable "db_ip" {
  description = "Ip privé de la base de donnée"
  default = "10.0.8.101"
}

variable "rproxy_ip" {
  description = "Ip privé du reverse proxys"
  default = "10.0.8.102"
}
