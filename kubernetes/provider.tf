terraform {
  required_providers {
    azurerm = {
        source  = "hashicorp/azurerm"
        version = "=3.0.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~>3.0"
    }
  }
  backend "azurerm" {
    resource_group_name     = "MyRgRemoteBackend"
    storage_account_name    = "storageremotetfmahdi"
    container_name          = "tfbackends"
    key                     = "GitHub-Terraform-rg-paas"
  }
}

provider "azurerm" {
  features {}
}
