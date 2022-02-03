resource "azurerm_postgresql_server" "az_psql" {
  name                = "task02-psql"
  location            = "${var.location}"
  resource_group_name = "${var.res_group_name}"

  administrator_login          = "psqladmin"
  administrator_login_password = "${var.pgsql_password}"

  sku_name     = "B_Gen5_2"

  storage_mb            = "${var.pgsql_storage}"
  backup_retention_days = "${var.pgsql_backup}"
  geo_redundant_backup_enabled = false
    
  version                      = "9.6"
  ssl_enforcement_enabled              = true
 
	 tags = {
    Environment = "${terraform.workspace}"
  }
}