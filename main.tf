data "azurerm_client_config" "core" {}

module "azure-storage-account" {    
    source = "./Modules/StorageAccount/"    
}

module "azurerm-virtual-machine" {    
     source = "./Modules/VM/" 
}