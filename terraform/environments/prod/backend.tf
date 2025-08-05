terraform {
  backend "azurerm" {
    resource_group_name  = "tfstate-rg"      
    storage_account_name = "tfstatestorageacct11"      
    container_name       = "tfstate"                 
    key                  = "VM.tfstate"  
  }
}


