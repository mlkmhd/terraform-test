resource "azurerm_container_group" "example" {
  count               = 1
  name                = count.index + 3
  location            = var.resource_group_location
  resource_group_name = azurerm_resource_group.rg.name
  ip_address_type     = "Public"
  dns_name_label      = "aci-v2ray-tom-${count.index + 3}"
  os_type             = "Linux"

  container {
    name   = "v2ray"
    image  = "v2fly/v2fly-core:v5.1.0"
    cpu    = "0.2"
    memory = "0.1"

    ports {
      port     = 6443
      protocol = "TCP"
    }

    commands = [ "v2ray", "run", "-c", "/etc/v2ray/config.json" ]
    
    volume {
      name                 = "config-volume"
      mount_path           = "/etc/v2ray"
      read_only            = false
      
      secret = {
        "config.json"      = "ewogICJsb2ciOiB7CiAgICAiYWNjZXNzIjogIi92YXIvbG9nL3YycmF5L2FjY2Vzcy5sb2ciLAogICAgImVycm9yIjogIi92YXIvbG9nL3YycmF5L2Vycm9yLmxvZyIsCiAgICAibG9nbGV2ZWwiOiAid2FybmluZyIKICB9LAogICJpbmJvdW5kcyI6IFsKICAgIHsKICAgICAgImxpc3RlbiI6ICIwLjAuMC4wIiwKICAgICAgInBvcnQiOiA2NDQzLAogICAgICAicHJvdG9jb2wiOiAidm1lc3MiLAogICAgICAic2V0dGluZ3MiOiB7CiAgICAgICAgImNsaWVudHMiOiBbCiAgICAgICAgICB7CiAgICAgICAgICAgICJpZCI6ICIzMDY2ZmNmNC1hNTJlLTExZWQtYjlkZi0wMjQyYWMxMjAwMDMiLAogICAgICAgICAgICAiYWx0ZXJJZCI6IDAsCiAgICAgICAgICAgICJzZWN1cml0eSI6ICJjaGFjaGEyMC1wb2x5MTMwNSIKICAgICAgICAgIH0KICAgICAgICBdCiAgICAgIH0sCiAgICAgICJzdHJlYW1TZXR0aW5ncyI6IHsKICAgICAgICAibmV0d29yayI6ICJ3cyIKICAgICAgfQogICAgfQogIF0sCiAgIm91dGJvdW5kIjogewogICAgInByb3RvY29sIjogImZyZWVkb20iLAogICAgInRhZyI6ICJmcmVlZG9tIgogIH0sCiAgImluYm91bmREZXRvdXIiOiBudWxsLAogICJvdXRib3VuZERldG91ciI6IFsKICAgIHsKICAgICAgInByb3RvY29sIjogImJsYWNraG9sZSIsCiAgICAgICJ0YWciOiAiYmxhY2tob2xlIgogICAgfQogIF0sCiAgInJvdXRpbmciOiB7CiAgICAiZG9tYWluU3RyYXRlZ3kiOiAiSVBJZk5vbk1hdGNoIiwKICAgICJzZXR0aW5ncyI6IHsKICAgICAgInJ1bGVzIjogWwogICAgICAgIHsKICAgICAgICAgICJ0eXBlIjogImZpZWxkIiwKICAgICAgICAgICJvdXRib3VuZFRhZyI6ICJibGFja2hvbGUiLAogICAgICAgICAgImlwIjogWwogICAgICAgICAgICAiZ2VvaXA6cHJpdmF0ZSIKICAgICAgICAgIF0KICAgICAgICB9CiAgICAgIF0KICAgIH0KICB9Cn0="
      }
    }
  }

  tags = {
    environment = "testing"
  }
}