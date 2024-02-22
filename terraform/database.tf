resource "azurerm_public_ip" "db_pub_ip" {
  name                = "ip-db-${var.short}"
  resource_group_name = azurerm_resource_group.rg_odoo.name
  location            = azurerm_resource_group.rg_odoo.location
  allocation_method   = "Dynamic"
}

resource "azurerm_network_interface" "db_nic" {
  name                = "nic-db-${var.short}"
  location            = azurerm_resource_group.rg_odoo.location
  resource_group_name = azurerm_resource_group.rg_odoo.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.odoo_sn.id
    private_ip_address_allocation = "Static"
    private_ip_address            = var.db_ip
    public_ip_address_id          = azurerm_public_ip.db_pub_ip.id

  }
}
resource "azurerm_managed_disk" "db_disk" {
  name                 = "disk-db-${var.short}"
  location             = azurerm_resource_group.rg_odoo.location
  resource_group_name  = azurerm_resource_group.rg_odoo.name
  storage_account_type = "Standard_LRS"
  create_option        = "Empty"
  disk_size_gb         = "1"
}

resource "azurerm_linux_virtual_machine" "db_vm" {
  name                = "vm-db-${var.short}"
  resource_group_name = azurerm_resource_group.rg_odoo.name
  location            = azurerm_resource_group.rg_odoo.location
  size                = "Standard_B1s"
  admin_username      = "dieu"
  computer_name       = "db"
  network_interface_ids = [
    azurerm_network_interface.db_nic.id,
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

resource "azurerm_virtual_machine_data_disk_attachment" "db_data_attachment" {
  managed_disk_id    = azurerm_managed_disk.db_disk.id
  virtual_machine_id = azurerm_linux_virtual_machine.db_vm.id
  lun                = "10"
  caching            = "ReadWrite"
}
