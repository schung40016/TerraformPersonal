# Create SQL Server instance
resource "azurerm_mssql_server" "my-SQLServ" {
  name                         = var.sqladmin_storacc_name
  resource_group_name          = var.sqladmin_res_name
  location                     = var.sqladmin_vnet_loc
  version                      = "12.0"
  administrator_login          = var.sqladmin_username
  administrator_login_password = var.sqladmin_password

  tags = {
    Environment = "Personal Project"
  }
}