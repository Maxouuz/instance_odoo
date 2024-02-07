resource "azurerm_public_ip" "jk_pi" {
  name                = "pi-jade-kozan-frc"
  resource_group_name = azurerm_resource_group.jk_rg.name
  location            = azurerm_resource_group.jk_rg.location
  allocation_method   = "Dynamic"

  tags = {
    environment = "Production"
  }
}

resource "azurerm_network_interface" "jk_ni" {
  name                = "ni-jade-kozan-frc"
  location            = "France Central"
  resource_group_name = azurerm_resource_group.jk_rg.name

  ip_configuration {
    name                          = azurerm_subnet.jk_sn.name
    subnet_id                     = azurerm_subnet.jk_sn.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_network_interface" "jk_ni_public" {
  name                = "ni-public-jade-kozan-frc"
  location            = "France Central"
  resource_group_name = azurerm_resource_group.jk_rg.name

  ip_configuration {
    name                          = "Public"
    subnet_id                     = azurerm_subnet.jk_sn.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.jk_pi.id
  }
}

resource "azurerm_network_interface" "jk_ni_odoo" {
  name                = "ni-odoo-jade-kozan-frc"
  location            = "France Central"
  resource_group_name = azurerm_resource_group.jk_rg.name

  ip_configuration {
    name                          = "Private"
    subnet_id                     = azurerm_subnet.jk_sn.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_network_interface" "jk_ni_psql" {
  name                = "ni-psql-jade-kozan-frc"
  location            = "France Central"
  resource_group_name = azurerm_resource_group.jk_rg.name

  ip_configuration {
    name                          = "Private"
    subnet_id                     = azurerm_subnet.jk_sn.id
    private_ip_address_allocation = "Dynamic"
  }
}

# Machine Reverse proxy

resource "azurerm_linux_virtual_machine" "jk_vm_reverseproxy" {
  name                = "vm-reverseproxy-jade-kozan-frc"
  resource_group_name = azurerm_resource_group.jk_rg.name
  location            = "France Central"
  size                = "Standard_B1s"
  admin_username      = "adminuser"
  computer_name       = "publicreverseproxy"
  network_interface_ids = [
    azurerm_network_interface.jk_ni_public.id,
    azurerm_network_interface.jk_ni.id
  ]

  admin_ssh_key {
    username   = "adminuser"
    public_key = file("~/.ssh/id_rsa.pub")
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Debian"
    offer     = "debian-11"
    sku       = "11-backports-gen2"
    version   = "latest"
  }
}

# Machine Postgresql

resource "azurerm_linux_virtual_machine" "jk_vm_psql" {
  name                = "vm-psql-jade-kozan-frc"
  resource_group_name = azurerm_resource_group.jk_rg.name
  location            = "France Central"
  size                = "Standard_B1s"
  admin_username      = "adminuser"
  computer_name       = "privatepsql"
  network_interface_ids = [
    azurerm_network_interface.jk_ni_psql.id
  ]

  admin_ssh_key {
    username   = "adminuser"
    public_key = file("~/.ssh/id_rsa.pub")
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
   
  source_image_reference {
    publisher = "Debian"
    offer     = "debian-11"
    sku       = "11-backports-gen2"
    version   = "latest"
  }
}

# Machine Odoo

resource "azurerm_linux_virtual_machine" "jk_vm_odoo" {
  name                = "vm-odoo-jade-kozan-frc"
  resource_group_name = azurerm_resource_group.jk_rg.name
  location            = "France Central"
  size                = "Standard_B1s"
  admin_username      = "adminuser"
  computer_name       = "privateodoo"
  network_interface_ids = [
    azurerm_network_interface.jk_ni_odoo.id
  ]

  admin_ssh_key {
    username   = "adminuser"
    public_key = file("~/.ssh/id_rsa.pub")
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  
  source_image_reference {
    publisher = "Debian"
    offer     = "debian-11"
    sku       = "11-backports-gen2"
    version   = "latest"
  }
}
