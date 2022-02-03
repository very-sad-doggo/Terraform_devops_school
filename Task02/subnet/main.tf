resource "azurerm_subnet" "subnet" {
  name                      = "task02-subnet"
  resource_group_name       = "${var.res_group_name}"
  virtual_network_name      = "${var.vnet_name}"
  address_prefixes            = "${var.subnet_prefix}"
}