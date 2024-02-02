output "public_ip_reverse_proxy" {
  value = azurerm_public_ip.jk_pi.ip_address
  description = "ip publique reverse proxy"
}

output "private_ip_reverse_proxy" {
  value = azurerm_network_interface.jk_ni.private_ip_address
  description = "ip privee odoo"
}

output "private_ip_psql" {
  value = azurerm_network_interface.jk_ni_psql.private_ip_address
  description = "ip privee psql"
}

output "private_ip_odoo" {
  value = azurerm_network_interface.jk_ni_odoo.private_ip_address
  description = "ip privee odoo"
}
