output "vnet_name" {
  value = data.azurerm_virtual_network.vnet.name
}
output "subnet_name" {
    value = data.azurerm_subnet.subnet.name
}
output "nsg_name" {
    value = data.azurerm_network_security_group.nsg.name
}
