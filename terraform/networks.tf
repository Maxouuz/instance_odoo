resource "azurerm_virtual_network" "vnet_odoo1" {
  name                = "vnet-odoo-vnet1-frc"
  resource_group_name = azurerm_resource_group.rg_odoo.name
  location            = azurerm_resource_group.rg_odoo.location
  address_space       = ["10.0.0.0/16"]
}

resource "azurerm_subnet" "snet_vnet1_odoo1" {
  name                 = "snet-iut-vnet1-odoo1-frc"
  virtual_network_name = azurerm_virtual_network.vnet_odoo1.name
  resource_group_name  = azurerm_resource_group.rg_odoo.name
  address_prefixes     = ["10.0.1.0/24"]
}