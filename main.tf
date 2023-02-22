# Configure the Azure provider
terraform {
  required_providers { # Defined provider restrictions here.
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0.2"
    }
  }

  required_version = ">= 1.1.0"
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "my-rg" {
  name     = "${var.project_name}ResourceGroup"
  location = var.resource_location

  tags = {
    Environment = "Personal Project"
    Team        = "Myself"
  }
}

# Create storage_account resource
resource "azurerm_storage_account" "my-SA" {
  name                     = "${lower(var.project_name)}storageaccount"
  resource_group_name      = azurerm_resource_group.my-rg.name
  location                 = azurerm_resource_group.my-rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}


# Create Service Plan
resource "azurerm_service_plan" "my-SP" {
  name                = "${var.project_name}ServicePlan"
  location            = azurerm_resource_group.my-rg.location
  resource_group_name = azurerm_resource_group.my-rg.name
  os_type             = "Linux"
  sku_name            = "P1v2"
}

module "vnet_inst" {
  source = "./modules/vnet"

  vnet_name         = "${var.project_name}VirtualNetwork"
  vnet_address      = var.vnet_address
  vnet_res_name     = azurerm_resource_group.my-rg.name
  vnet_res_location = azurerm_resource_group.my-rg.location
}

#Create SQL Server
module "mysql_inst" {
  source = "./modules/sqlserver"

  sqladmin_username     = var.sqladmin_username
  sqladmin_password     = var.sqladmin_password
  sqladmin_storacc_name = azurerm_storage_account.my-SA.name
  sqladmin_res_name     = azurerm_resource_group.my-rg.name
  sqladmin_vnet_loc     = module.vnet_inst.vn_loc
}

# Create Azure Logic apps
module "logicapp_insts" {
  source = "./modules/logicapp"

  logicapp_count    = var.logic_count
  logicapp_name     = "${var.project_name}LogicApp"
  logicapp_res_name = azurerm_resource_group.my-rg.name
  logicapp_vnet_loc = module.vnet_inst.vn_loc
}

# Create Azure Function apps
module "funcapp_insts" {
  source = "./modules/funcapp"

  func_count       = var.func_count
  func_name        = "${var.project_name}FunctionApp"
  func_vnet_loc    = module.vnet_inst.vn_loc
  func_res_name    = azurerm_resource_group.my-rg.name
  func_servplan_id = azurerm_service_plan.my-SP.id
  func_stor_name   = azurerm_storage_account.my-SA.name
  func_stor_acckey = azurerm_storage_account.my-SA.primary_access_key
}
