resource "azurerm_postgresql_server" "az_psql" {
  name                = "az-${terraform.workspace}-psql"
  location            = "${var.location}"
  resource_group_name = "${var.res_group_name}"

  administrator_login          = "psqladmin"
  administrator_login_password = "${var.pgsql_password}"

  sku_name     = "B_Gen5_2"
  #capacity = "${var.pgsql_capacity[terraform.workspace]}"
  #tier     = "${var.pgsql_tier[terraform.workspace]}"
  #family   = "Gen5"

  storage_mb            = "${var.pgsql_storage[terraform.workspace]}"
  backup_retention_days = "${var.pgsql_backup[terraform.workspace]}"
  geo_redundant_backup_enabled = false
  #geo_redundant_backup  = "${var.pgsql_redundant_backup[terraform.workspace]}"
  
  version                      = "9.6"
  ssl_enforcement_enabled              = true
 
	 tags = {
    Environment = "${terraform.workspace}"
  }
}