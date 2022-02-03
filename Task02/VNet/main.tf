resource "azurerm_virtual_network" "vnet" {
  name          = "vnet-task02"
  address_space = ["${var.address_space}"]

  location            = "${var.location}"
  resource_group_name = "${var.res_group_name}"

  tags = {
    environment = "study"
  }
}