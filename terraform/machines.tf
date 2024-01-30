resource "azurerm_public_ip" "pip_vm1_pip1" {
  name                = "pip-vm1-pip1-frc"
  resource_group_name = azurerm_resource_group.rg_odoo.name
  location            = azurerm_resource_group.rg_odoo.location
  allocation_method   = "Dynamic"
}

resource "azurerm_network_interface" "nic_vm1_nic1" {
  name                = "nic-vm1-nic1-frc"
  resource_group_name = azurerm_resource_group.rg_odoo.name
  location            = azurerm_resource_group.rg_odoo.location

  ip_configuration {
    name                          = "primary"
    subnet_id                     = azurerm_subnet.snet_vnet1_odoo1.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.pip_vm1_pip1.id
  }
}

resource "azurerm_linux_virtual_machine" "vm_odoo_odooServer" {
  name                            = "vm-iut-vm1-frc"
  resource_group_name             = azurerm_resource_group.rg_odoo.name
  location                        = azurerm_resource_group.rg_odoo.location
  size                            = "Standard_B1s"
  admin_username                  = "adminuser"
  disable_password_authentication = true

  network_interface_ids = [
    azurerm_network_interface.nic_vm1_nic1.id
  ]

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }

  os_disk {
    storage_account_type = "Standard_LRS"
    caching              = "ReadWrite"
  }

  admin_ssh_key {
    public_key = file(".ssh/id_rsa.pub") # A ajuster à votre cas.
    username = "adminuser"
  }
}