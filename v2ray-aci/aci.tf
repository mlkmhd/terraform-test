resource "azurerm_container_group" "example" {
  count               = 4
  name                = count.index
  location            = var.resource_group_location
  resource_group_name = azurerm_resource_group.rg.name
  ip_address_type     = "Public"
  dns_name_label      = "aci-v2ray-tom-${count.index}"
  os_type             = "Linux"

  container {
    name   = "v2ray"
    image  = "v2fly/v2fly-core:latest"
    cpu    = "0.2"
    memory = "0.2"

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
        "config.json"      = "ewogICJsb2ciOiB7CiAgICAiYWNjZXNzIjogIi92YXIvbG9nL3YycmF5L2FjY2Vzcy5sb2ciLAogICAgImVycm9yIjogIi92YXIvbG9nL3YycmF5L2Vycm9yLmxvZyIsCiAgICAibG9nbGV2ZWwiOiAid2FybmluZyIKICB9LAogICJpbmJvdW5kcyI6IFsKICAgIHsKICAgICAgImxpc3RlbiI6ICIwLjAuMC4wIiwKICAgICAgInBvcnQiOiA4MDgwLAogICAgICAicHJvdG9jb2wiOiAidm1lc3MiLAogICAgICAic2V0dGluZ3MiOiB7CiAgICAgICAgImNsaWVudHMiOiBbCiAgICAgICAgICB7CiAgICAgICAgICAgICJpZCI6ICIyNmJkMjU0MC1jYTQzLTRiMzEtYTFlYy0zN2I4ODNkOWFjNGYiLAogICAgICAgICAgICAiYWx0ZXJJZCI6IDY0LAogICAgICAgICAgICAic2VjdXJpdHkiOiAiY2hhY2hhMjAtcG9seTEzMDUiCiAgICAgICAgICB9CiAgICAgICAgXQogICAgICB9LAogICAgICAic3RyZWFtU2V0dGluZ3MiOiB7CiAgICAgICAgIm5ldHdvcmsiOiAidGNwIiwKICAgICAgICAidGNwU2V0dGluZ3MiOiB7CiAgICAgICAgICAiaGVhZGVyIjogewogICAgICAgICAgICAidHlwZSI6ICJodHRwIiwKICAgICAgICAgICAgInJlc3BvbnNlIjogewogICAgICAgICAgICAgICJ2ZXJzaW9uIjogIjEuMSIsCiAgICAgICAgICAgICAgInN0YXR1cyI6ICIyMDAiLAogICAgICAgICAgICAgICJyZWFzb24iOiAiT0siLAogICAgICAgICAgICAgICJoZWFkZXJzIjogewogICAgICAgICAgICAgICAgIkNvbnRlbnQtVHlwZSI6IFsKICAgICAgICAgICAgICAgICAgImFwcGxpY2F0aW9uL29jdGV0LXN0cmVhbSIsCiAgICAgICAgICAgICAgICAgICJhcHBsaWNhdGlvbi94LW1zZG93bmxvYWQiLAogICAgICAgICAgICAgICAgICAidGV4dC9odG1sIiwKICAgICAgICAgICAgICAgICAgImFwcGxpY2F0aW9uL3gtc2hvY2t3YXZlLWZsYXNoIgogICAgICAgICAgICAgICAgXSwKICAgICAgICAgICAgICAgICJUcmFuc2Zlci1FbmNvZGluZyI6IFsKICAgICAgICAgICAgICAgICAgImNodW5rZWQiCiAgICAgICAgICAgICAgICBdLAogICAgICAgICAgICAgICAgIkNvbm5lY3Rpb24iOiBbCiAgICAgICAgICAgICAgICAgICJrZWVwLWFsaXZlIgogICAgICAgICAgICAgICAgXSwKICAgICAgICAgICAgICAgICJQcmFnbWEiOiAibm8tY2FjaGUiCiAgICAgICAgICAgICAgfQogICAgICAgICAgICB9CiAgICAgICAgICB9CiAgICAgICAgfQogICAgICB9CiAgICB9LAogICAgewogICAgICAibGlzdGVuIjogIjAuMC4wLjAiLAogICAgICAicG9ydCI6IDY0NDMsCiAgICAgICJwcm90b2NvbCI6ICJ2bWVzcyIsCiAgICAgICJzZXR0aW5ncyI6IHsKICAgICAgICAiY2xpZW50cyI6IFsKICAgICAgICAgIHsKICAgICAgICAgICAgImlkIjogIjI2YmQyNTQwLWNhNDMtNGIzMS1hMWVjLTM3Yjg4M2Q5YWM0ZiIsCiAgICAgICAgICAgICJhbHRlcklkIjogMCwKICAgICAgICAgICAgInNlY3VyaXR5IjogImNoYWNoYTIwLXBvbHkxMzA1IgogICAgICAgICAgfQogICAgICAgIF0KICAgICAgfSwKICAgICAgInN0cmVhbVNldHRpbmdzIjogewogICAgICAgICJuZXR3b3JrIjogIndzIgogICAgICB9CiAgICB9CiAgXSwKICAib3V0Ym91bmQiOiB7CiAgICAicHJvdG9jb2wiOiAiZnJlZWRvbSIsCiAgICAidGFnIjogImZyZWVkb20iCiAgfSwKICAiaW5ib3VuZERldG91ciI6IG51bGwsCiAgIm91dGJvdW5kRGV0b3VyIjogWwogICAgewogICAgICAicHJvdG9jb2wiOiAiYmxhY2tob2xlIiwKICAgICAgInRhZyI6ICJibGFja2hvbGUiCiAgICB9CiAgXSwKICAicm91dGluZyI6IHsKICAgICJkb21haW5TdHJhdGVneSI6ICJJUElmTm9uTWF0Y2giLAogICAgInNldHRpbmdzIjogewogICAgICAicnVsZXMiOiBbCiAgICAgICAgewogICAgICAgICAgInR5cGUiOiAiZmllbGQiLAogICAgICAgICAgIm91dGJvdW5kVGFnIjogImJsYWNraG9sZSIsCiAgICAgICAgICAiaXAiOiBbCiAgICAgICAgICAgICJnZW9pcDpwcml2YXRlIgogICAgICAgICAgXQogICAgICAgIH0KICAgICAgXQogICAgfQogIH0KfQ=="
      }
    }
  }

  tags = {
    environment = "testing"
  }
}