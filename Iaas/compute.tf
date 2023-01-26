resource "tls_private_key" "example_ssh" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "azurerm_linux_virtual_machine" "vm" {
  name                  = "bookvm"
  location              = var.location
  resource_group_name   = azurerm_resource_group.rg.name
  admin_username        = "mahdi"
  size                  = "Standard_DS1_v2"
  network_interface_ids = ["${azurerm_network_interface.nic.id}"]
  os_disk {
    name                 = "myOsDisk"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }
  admin_ssh_key {
    username   = "mahdi"
    public_key = tls_private_key.example_ssh.public_key_openssh
  }
}
