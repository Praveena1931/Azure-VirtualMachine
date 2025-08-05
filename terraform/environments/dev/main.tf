provider "azurerm" {
  features {}
}

module "" {
  source                  = "../../modules/VM"
  resource_group_name     = var.resource_group_name
  resource_group_location = var.resource_group_location
  virtual_network_name    = var.vnet_name
  vnet_address_space      = var.vnet_address_space
  subnet_name             = var.subnet_name
  subnet_address_prefixes = var.subnet_address_prefixes
  network_interface_name  = var.nic_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.Subnet.id
    private_ip_address_allocation = "Dynamic"
  }

  virtual_machine_name    = var.vm_name
  vm_size                 = var.vm_size
  admin_username          = "adminuser"
    
  network_interface_ids = [
    azurerm_network_interface.nic.id,
  ]

  admin_ssh_key {
    username   = "azureuser"
    public_key = var.ssh_public_key
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
}


