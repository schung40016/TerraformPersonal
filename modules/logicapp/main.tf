# Create 2 Azure Logic apps
resource "azurerm_logic_app_workflow" "my-LogApp" {
  count               = var.logicapp_count
  name                = "${var.logicapp_name}.${count.index}"
  location            = var.logicapp_vnet_loc
  resource_group_name = var.logicapp_res_name

  tags = {
    Environment = "Personal Project"
  }
}