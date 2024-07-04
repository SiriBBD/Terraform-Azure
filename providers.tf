provider "azurerm" {
  subscription_id = var.subscriptionid
  tenant_id       = var.tenantid
  features {}
}