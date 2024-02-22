output "odoo_ip" {
  value = azurerm_public_ip.odoo_pub_ip.ip_address
  description = "ip publique machine odoo"
}

output "db_ip" {
  value = azurerm_public_ip.db_pub_ip.ip_address
  description = "ip publique machine base de données"
}

output "rproxy_ip" {
  value = azurerm_public_ip.rproxy_pub_ip.ip_address
  description = "ip publique reverse proxy"
}
