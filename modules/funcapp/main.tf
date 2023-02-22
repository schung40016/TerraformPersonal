# Create Azure Function apps
resource "azurerm_function_app" "my-funcbatch" {
  count                      = var.func_count
  name                       = "${var.func_name}${count.index}"
  location                   = var.func_vnet_loc
  resource_group_name        = var.func_res_name
  app_service_plan_id        = var.func_servplan_id
  storage_account_name       = var.func_stor_name
  storage_account_access_key = var.func_stor_acckey
}