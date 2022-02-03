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
variable "location" {
  default     = "ukwest"
  description = "Azure location"
}
variable "res_group"{
    default = "vladimir-ryadovoy-tfhomework"
}
variable "address_space" {
  description = "CIDR for the whole VNet"

  default = "10.10.0.0/16"
}
variable "subnet_prefix" {
  description = "CIDR for the subnet"

  default = ["10.10.0.0/24"]
}