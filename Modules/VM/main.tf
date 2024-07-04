resource "azurerm_resource_group" "appl_group" {
  name     = var.applgroup
  location = var.regioname
}

resource "azurerm_virtual_network" "appl_vnetwork" {
  name                = var.virtnetworkname
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.appl_group.location
  resource_group_name = azurerm_resource_group.appl_group.name
  depends_on = [ azurerm_resource_group.appl_group ]
}

resource "azurerm_subnet" "appl_snet" {
  name                 = var.subnet
  resource_group_name  = azurerm_resource_group.appl_group.name
  virtual_network_name = azurerm_virtual_network.appl_vnetwork.name
  address_prefixes     = ["10.0.2.0/24"]
  depends_on = [ azurerm_virtual_network.appl_vnetwork ]
}

resource "azurerm_network_interface" "appl_interface" {
  name                =  var.ninterface
  location            = azurerm_resource_group.appl_group.location
  resource_group_name = azurerm_resource_group.appl_group.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.appl_snet.id
    private_ip_address_allocation = "Dynamic"
  }
  depends_on = [ azurerm_subnet.appl_snet ]
}

resource "azurerm_windows_virtual_machine" "appl_vm" {
  name                = "appl-vm"
  resource_group_name = azurerm_resource_group.appl_group.name
  location            = azurerm_resource_group.appl_group.location
  size                = "Standard_DS1_v2"
  admin_username      = "demouser"
  admin_password      = "Azure@123"
  network_interface_ids = [
    azurerm_network_interface.appl_interface.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2019-Datacenter"
    version   = "latest"
    
  }
  depends_on = [ azurerm_network_interface.appl_interface ]
}