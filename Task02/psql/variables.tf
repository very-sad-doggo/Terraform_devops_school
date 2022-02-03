variable "location" {
  description = "Azure location"
}

variable "res_group_name" {
  description = "Azure resource group name"
}

variable "pgsql_capacity" {
  description = "PSQL Capacity"
}

variable "pgsql_tier" {
  description = "The tier of the particular SKU"
}

variable "pgsql_storage" {
  description = "Max storage allowed for a server"
}

variable "pgsql_backup" {
  description = "Backup retention days for the server, supported values are between 7 and 35 days."
}

variable "pgsql_redundant_backup" {
  description = "Enable Geo-redundant or not for server backup"
}

variable "pgsql_password" {
  description = "DB password"
}