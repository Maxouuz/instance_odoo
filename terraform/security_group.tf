resource "azurerm_network_security_group" "odoo_nsg" {
  name                = "nsg-${var.name}-${var.short}"
  location            = azurerm_resource_group.rg_odoo.location
  resource_group_name = azurerm_resource_group.rg_odoo.name

  security_rule {
    name                       = "AllowSSHAdmin"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "AllowHTTPWorldwide"
    priority                   = 110
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80-85"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "AllowLocalTrafic"
    priority                   = 120
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "10.0.8.0/24"
    destination_address_prefix = "10.0.8.0/24"
  }
}

resource "azurerm_subnet_network_security_group_association" "odoo_nsg_association" {
  subnet_id                 = azurerm_subnet.odoo_sn.id
  network_security_group_id = azurerm_network_security_group.odoo_nsg.id
}