provider "azurerm" {
  features {}
  subscription_id = "${var.subscription_id}"
  client_id       = "${var.client_id}"
  client_secret   = "${var.client_secret}"
  tenant_id       = "${var.tenant_id}"
}
#Determine script to install nginx in vm resource
data "template_file" "nginx-install" {
  template = file("install_nginx.sh")
}
#create vnet, described in the module
module "vnet" {
  source         = "./VNet"
  address_space  = "${var.address_space}"
  location       = "${var.location}"
  res_group_name = "${var.res_group}"
}
#create subnet, described in the module
module "subnet" {
  source           = "./subnet"
  res_group_name   = "${var.res_group}"
  vnet_name        = "${module.vnet.vnet_name}"
  subnet_prefix  = "${var.subnet_prefix}"
}
#create public ip for our vm
resource "azurerm_public_ip" "task02-vm-pub-ip" {
  name = "task02-ip"
  location = "${var.location}"
  resource_group_name = "${var.res_group}"
  allocation_method = "Static"
}
#create NIC and configure it for both pub ip and internal subnet
resource "azurerm_network_interface" "nic" {
  name                = "tftask02-nic"
  location            = "${var.location}"
  resource_group_name = "${var.res_group}"

  ip_configuration {
    name                          = "tftask02_ipconf"
    subnet_id                     = "${module.subnet.subnet_id}"
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = azurerm_public_ip.task02-vm-pub-ip.id
  }
}
#create vm with our script to install nginx
resource "azurerm_linux_virtual_machine" "nginx_vm" {
  name                = "tftask02"
  resource_group_name = "${var.res_group}"
  location            = "${var.location}"
  size                = "Standard_F2"
  admin_username      = "adminuser"
  network_interface_ids = [
    azurerm_network_interface.nic.id,
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
#create pgsql cluster
module "psql" {
  source                 = "./psql"
  location               = "${var.location}"
  res_group_name         = "${var.res_group}"
  pgsql_capacity         = "${var.pgsql_capacity}"
  pgsql_tier             = "${var.pgsql_tier}"
  pgsql_storage          = "${var.pgsql_storage}"
  pgsql_backup           = "${var.pgsql_backup}"
  pgsql_redundant_backup = "${var.pgsql_redundant_backup}"
  pgsql_password         = "${var.pgsql_password}"
}