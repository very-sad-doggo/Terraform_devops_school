data "azurerm_virtual_network" "vnet" {
    resource_group_name = "${var.resource_group}"
    name = "${var.vnet}"
}
data "azurerm_subnet" "subnet" {
  name                 = "${var.subnet}"
  virtual_network_name = "${var.vnet}"
  resource_group_name  = "${var.resource_group}"
}
data "azurerm_network_security_group" "nsg" {
  name                = "aks-agentpool-40499165-nsg"
  resource_group_name = "MC_vladimir-ryadovoy-diploma_k8s-dev_ukwest"
}