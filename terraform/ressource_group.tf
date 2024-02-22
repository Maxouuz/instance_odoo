resource "azurerm_resource_group" "rg_odoo" {
  name     = "rg-${var.name}-${var.short}"
  location = "${var.location}"
}