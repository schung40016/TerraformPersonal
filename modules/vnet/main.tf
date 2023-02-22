# Create Virtual Network
resource "azurerm_virtual_network" "my-Vnet" {
  name                = var.vnet_name
  address_space       = [var.vnet_address]
  location            = var.vnet_res_location
  resource_group_name = var.vnet_res_name
}
