resource "azurerm_storage_account" "aci_storage" {
  name                     = "v2rayconfigstorage"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = var.resource_group_location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  min_tls_version          = "TLS1_2"
}
resource "azurerm_storage_share" "container_share" {
  name                 = "aci-data"
  storage_account_name = azurerm_storage_account.aci_storage.name
  quota                = 1
}