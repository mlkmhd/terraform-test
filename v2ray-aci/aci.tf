resource "azurerm_container_group" "example" {
  count               = 1
  name                = count.index + 9
  location            = var.resource_group_location
  resource_group_name = azurerm_resource_group.rg.name
  ip_address_type     = "Public"
  dns_name_label      = "aci-v2ray-tom-${count.index + 9}"
  os_type             = "Linux"

  container {
    name   = "v2ray"
    image  = "v2fly/v2fly-core:v5.1.0"
    cpu    = "0.1"
    memory = "0.2"

    ports {
      port     = 443
      protocol = "TCP"
    }

    commands = [ "v2ray", "run", "-c", "/etc/v2ray/config.json" ]
    
    volume {
      name                 = "config-volume"
      mount_path           = "/etc/v2ray"
      read_only            = false
      
      secret = {
        "config.json"      = "ewogICJsb2ciOiB7CiAgICAiYWNjZXNzIjogIi92YXIvbG9nL3YycmF5L2FjY2Vzcy5sb2ciLAogICAgImVycm9yIjogIi92YXIvbG9nL3YycmF5L2Vycm9yLmxvZyIsCiAgICAibG9nbGV2ZWwiOiAid2FybmluZyIKICB9LAogICJpbmJvdW5kcyI6IFsKICAgIHsKICAgICAgImxpc3RlbiI6ICIwLjAuMC4wIiwKICAgICAgInBvcnQiOiA0NDMsCiAgICAgICJwcm90b2NvbCI6ICJ2bWVzcyIsCiAgICAgICJzZXR0aW5ncyI6IHsKICAgICAgICAiY2xpZW50cyI6IFsKICAgICAgICAgIHsKICAgICAgICAgICAgImlkIjogIjMwNjZmY2Y0LWE1MmUtMTFlZC1iOWRmLTAyNDJhYzEyMTIzMyIsCiAgICAgICAgICAgICJhbHRlcklkIjogMCwKICAgICAgICAgICAgInNlY3VyaXR5IjogImNoYWNoYTIwLXBvbHkxMzA1IgogICAgICAgICAgfQogICAgICAgIF0KICAgICAgfSwKICAgICAgInN0cmVhbVNldHRpbmdzIjogewogICAgICAgICJuZXR3b3JrIjogIndzIgogICAgICB9CiAgICB9CiAgXSwKICAib3V0Ym91bmQiOiB7CiAgICAicHJvdG9jb2wiOiAiZnJlZWRvbSIsCiAgICAidGFnIjogImZyZWVkb20iCiAgfSwKICAiaW5ib3VuZERldG91ciI6IG51bGwsCiAgIm91dGJvdW5kRGV0b3VyIjogWwogICAgewogICAgICAicHJvdG9jb2wiOiAiYmxhY2tob2xlIiwKICAgICAgInRhZyI6ICJibGFja2hvbGUiCiAgICB9CiAgXSwKICAicm91dGluZyI6IHsKICAgICJkb21haW5TdHJhdGVneSI6ICJJUElmTm9uTWF0Y2giLAogICAgInNldHRpbmdzIjogewogICAgICAicnVsZXMiOiBbCiAgICAgICAgewogICAgICAgICAgInR5cGUiOiAiZmllbGQiLAogICAgICAgICAgIm91dGJvdW5kVGFnIjogImJsYWNraG9sZSIsCiAgICAgICAgICAiaXAiOiBbCiAgICAgICAgICAgICJnZW9pcDpwcml2YXRlIgogICAgICAgICAgXQogICAgICAgIH0KICAgICAgXQogICAgfQogIH0KfQ=="
      }
    }
  }

  tags = {
    environment = "testing"
  }
}