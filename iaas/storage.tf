resource "azurerm_storage_account" "stor" {
  name                     = "bookstormahdi"
  location                 = var.location
  resource_group_name      = azurerm_resource_group.rg.name
  account_tier             = "Standard"
  account_replication_type = "LRS"
}
