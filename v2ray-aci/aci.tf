resource "azurerm_container_group" "example" {
  name                = "v2ray"
  location            = var.resource_group_location
  resource_group_name = azurerm_resource_group.rg.name
  ip_address_type     = "Public"
  dns_name_label      = "aci-label"
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
  }

  tags = {
    environment = "testing"
  }
}