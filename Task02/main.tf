provider "azurerm" {
  features {}
  subscription_id = "${var.subscription_id}"
  client_id       = "${var.client_id}"
  client_secret   = "${var.client_secret}"
  tenant_id       = "${var.tenant_id}"
}
data "template_file" "nginx-install" {
  template = file("install_nginx.sh")
}
module "vnet" {
  source         = "./VNet"
  address_space  = "${var.address_space}"
  location       = "${var.location}"
  res_group_name = "${var.res_group}"
}
module "subnet" {
  source           = "./subnet"
  res_group_name   = "${var.res_group}"
  vnet_name        = "${module.vnet.vnet_name}"
  subnet_prefix  = "${var.subnet_prefixes}"
}
resource "azurerm_network_interface" "nic" {
  name                = "tftask02-nic"
  location            = "${var.location}"
  resource_group_name = "${var.res_group}"

  ip_configuration {
    name                          = "tftask02_ipconf"
    subnet_id                     = "${module.subnet.id}"
    private_ip_address_allocation = "Dynamic"
  }
}
resource "azurerm_linux_virtual_machine" "nginx_vm" {
  name                = "tftask02"
  resource_group_name = "${var.res_group}"
  location            = "${var.location}"
  size                = "Standard_F2"
  admin_username      = "adminuser"
  network_interface_ids = [
    "${var.nic.id}",
  ]

  admin_ssh_key {
    username   = "adminuser"
    public_key = file("~/.ssh/id_rsa.pub")
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }
  custom_data = base64encode(data.template_file.nginx-install.rendered)
}
