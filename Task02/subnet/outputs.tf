output "subnet_id" {
  value = "${azurerm_subnet.subnet.id}"
}

output "subnet_address_prefix" {
  value = "${azurerm_subnet.subnet.address_prefix}"
}