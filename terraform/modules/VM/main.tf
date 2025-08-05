resource "azurerm_resource_group" "VMResource" {
  name     = var.resource_group_name
  location = var.resource_group_location
}

resource "azurerm_virtual_network" "VMNetwork" {
  name                = var.vnet_name
  address_space       = var.vnet_address_space
  location            = azurerm_resource_group.VMResource.location
  resource_group_name = azurerm_resource_group.VMResource.name
}

resource "azurerm_subnet" "Subnet" {
  name                 = var.subnet_name
  resource_group_name  = azurerm_resource_group.VMResource.name
  virtual_network_name = azurerm_virtual_network.VMNetwork.name
  address_prefixes     = var.subnet_address_prefixes
}

resource "azurerm_network_interface" "nic" {
  name                = var.nic_name
  location            = azurerm_resource_group.VMResource.location
  resource_group_name = azurerm_resource_group.VMResource.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.Subnet.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_linux_virtual_machine" "VM" {
  name                = var.vm_name
  resource_group_name = azurerm_resource_group.VMResource.name
  location            = azurerm_resource_group.VMResource.location
  size                = var.vm_size
  admin_username      = "adminuser"
  network_interface_ids = [
    azurerm_network_interface.nic.id,
  ]

  admin_ssh_key {
    username   = "adminuser"
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