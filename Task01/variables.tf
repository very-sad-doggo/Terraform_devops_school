variable "subscription_id" {
  description = "Azure subscription_id"
}
variable "client_id" {
  description = "Azure client_id"
}
variable "client_secret" {
  description = "Azure password"
}
variable "tenant_id" {
  description = "Azure tenant_id"
}
variable "resource_group" {
    description = "resource group name"
    default = "vladimir-ryadovoy-diploma"
}
variable "vnet" {
    description = "vnet name"
    default = "vnet-dev"
}
variable "subnet" {
    description = "subnet name"
    default = "aks-dev-subnet"
}