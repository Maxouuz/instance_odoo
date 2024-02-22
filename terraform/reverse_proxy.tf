resource "azurerm_public_ip" "rproxy_pub_ip" {
  name                = "ip-rproxy-${var.short}"
  resource_group_name = azurerm_resource_group.rg_odoo.name
  location            = azurerm_resource_group.rg_odoo.location
  allocation_method   = "Dynamic"
}

resource "azurerm_network_interface" "rproxy_nic" {
  name                = "nic-rproxy-${var.short}"
  location            = azurerm_resource_group.rg_odoo.location
  resource_group_name = azurerm_resource_group.rg_odoo.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.odoo_sn.id
    private_ip_address_allocation = "Static"
    private_ip_address            = var.rproxy_ip
    public_ip_address_id          = azurerm_public_ip.rproxy_pub_ip.id
  }
}

resource "azurerm_linux_virtual_machine" "rproxy_vm" {
  name                = "vm-rproxy-${var.short}"
  resource_group_name = azurerm_resource_group.rg_odoo.name
  location            = azurerm_resource_group.rg_odoo.location
  size                = "Standard_B1s"
  admin_username      = "dieu"
  computer_name       = "rproxy"
  network_interface_ids = [
    azurerm_network_interface.rproxy_nic.id,
  ]

  admin_ssh_key {
    username   = "dieu"
    public_key = file("~/.ssh/id_rsa.pub")
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    offer     = "0001-com-ubuntu-server-focal"
    publisher = "Canonical"
    sku       = "20_04-lts-gen2"
    version   = "latest"
  }
}