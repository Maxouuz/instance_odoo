resource "azurerm_virtual_network" "odoo_vn" {
  name                = "vn-${var.name}-${var.short}"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.rg_odoo.location
  resource_group_name = azurerm_resource_group.rg_odoo.name
}

resource "azurerm_subnet" "odoo_sn" {
  name                 = "sn-${var.name}-${var.short}"
  resource_group_name  = azurerm_resource_group.rg_odoo.name
  virtual_network_name = azurerm_virtual_network.odoo_vn.name
  address_prefixes     = ["10.0.8.0/24"]
}
