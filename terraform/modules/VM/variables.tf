variable "resource_group_name" {
  description = "The name of the Azure Resource Group"
  type        = string
}

variable "resource_group_location" {
  description = "The Azure region where the Resource Group will be created"
  type        = string
}

variable "vnet_name" {
  description = "The name of the virtual network"
  type        = string
}

variable "vnet_address_space" {
  description = "The address space for the virtual network"
  type        = list(string)
}

variable "subnet_name" {
  description = "The name of the subnet"
  type        = string
}

variable "subnet_address_prefixes" {
  description = "The address prefixes for the subnet"
  type        = list(string)
}

variable "nic_name" {
  description = "The name of the network interface"
  type        = string
}

variable "vm_name" {
  description = "The name of the virtual machine"
  type        = string
}

variable "vm_size" {
  description = "The size of the virtual machine"
  type        = string
}

variable "admin_username" {
  description = "The admin username for the virtual machine"
  type        = string
}

variable "ssh_public_key" {
  description = "The SSH public key for the VM"
  type        = string
  sensitive   = true
}

