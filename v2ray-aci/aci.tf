resource "azurerm_container_group" "example" {
  name                = "v2ray"
  location            = var.resource_group_location
  resource_group_name = azurerm_resource_group.rg.name
  ip_address_type     = "Public"
  dns_name_label      = "aci-v2ray-tom"
  os_type             = "Linux"

  container {
    name   = "v2ray"
    image  = "v2fly/v2fly-core:latest"
    cpu    = "0.5"
    memory = "0.5"

    ports {
      port     = 6443
      protocol = "TCP"
    }

    # commands = [ "v2ray", "run", "-c", "/etc/v2ray/config.json" ]
    commands = [ "ls", "-lth", "/etc/v2ray/config.json" ]

    volume {
      name                 = "config-volume"
      mount_path           = "/etc/v2ray"
      storage_account_name = azurerm_storage_account.aci_storage.name
      storage_account_key  = azurerm_storage_account.aci_storage.primary_access_key
      share_name           = azurerm_storage_share.container_share.name
    }
  }

  tags = {
    environment = "testing"
  }
}