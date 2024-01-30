resource "azurerm_virtual_network" "jk_vn" {
  name                = "nw-jade-kozan-frc"
  address_space       = ["10.0.0.0/16"]
  location            = "France Central"
  resource_group_name = azurerm_resource_group.jk_rg.name
}

resource "azurerm_subnet" "jk_sn" {
  name                 = "sn-jade-kozan-frc"
  resource_group_name  = azurerm_resource_group.jk_rg.name
  virtual_network_name = azurerm_virtual_network.jk_vn.name
  address_prefixes     = ["10.0.2.0/24"]
}