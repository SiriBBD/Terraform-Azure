resource "azurerm_resource_group" "demo_resgroup" {
  name=var.createdresourcename
  location = var.locationame
}

resource "azurerm_storage_account" "demo_storageacc" {
  name                     = var.createdstorageaccountname
  resource_group_name      = var.createdresourcename
  location                 = var.locationame
  account_tier             = "Standard"
  account_replication_type = "LRS"
  depends_on = [ azurerm_resource_group.demo_resgroup ]

}


resource "azurerm_storage_container" "demo_storagecontainer" {
  name                  = var.createdstoragecontainer
  storage_account_name  = var.createdstorageaccountname
  container_access_type = "private"
  depends_on            = [azurerm_storage_account.demo_storageacc]
}

// Used to upload local file to containier 
resource "azurerm_storage_blob" "sample" {
  name                   = "sample.txt"
  storage_account_name   = var.createdstorageaccountname
  storage_container_name = var.createdstoragecontainer
  type                   = "Block"
  source                 = "sample.txt"
  depends_on             = [azurerm_storage_container.demo_storagecontainer]
}
