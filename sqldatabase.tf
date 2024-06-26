/*

The following links provide the documentation for the new blocks used
in this terraform configuration file

1. azurerm_mssql_server - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/mssql_server

2. azurerm_mssql_database - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/mssql_database

*/

data "azurerm_client_config" "current" {
}

data "http" "currentip" {
  url = "https://ipv4.icanhazip.com"
}

resource "azurerm_mssql_server" "sqlserver" {
  name                         = "sqlserver400908"
  resource_group_name          = azurerm_resource_group.appgrp.name
  location                     = azurerm_resource_group.appgrp.location
  version                      = "12.0"
  administrator_login          = "sqladmin"
  administrator_login_password = "Azure@3456"  
  depends_on = [
    azurerm_resource_group.appgrp
  ]
}

resource "azurerm_mssql_database" "sqldatabase" {
  name           = "sqldatabase"
  server_id      = azurerm_mssql_server.sqlserver.id
  collation      = "SQL_Latin1_General_CP1_CI_AS"
  license_type   = "LicenseIncluded"
  max_size_gb    = 2  
  sku_name       = "Basic"  

  lifecycle {
    ignore_changes = [
      license_type
    ]
  }
  
  depends_on = [
    azurerm_mssql_server.sqlserver
      ]
  
}

resource "azurerm_mssql_firewall_rule" "azure_services" {
  name             = "FirewallRule1"
  server_id        = azurerm_mssql_server.sqlserver.id
  start_ip_address = "0.0.0.0"
  end_ip_address   = "0.0.0.0"
  depends_on = [
    azurerm_mssql_server.sqlserver
  ]
}

resource "azurerm_mssql_firewall_rule" "current_ip" {
  name             = "MyCurrentIP"
  server_id        = azurerm_mssql_server.sqlserver.id
  start_ip_address = chomp(data.http.currentip.response_body)
  end_ip_address   = chomp(data.http.currentip.response_body)
}

resource "null_resource" "init_sql_db" {
  depends_on = [azurerm_mssql_database.sqldatabase, azurerm_mssql_firewall_rule.azure_services]

  triggers = {
    always_run = timestamp()
  }

  provisioner "local-exec" {
    environment = {
      SQLCMDPASSWORD = azurerm_mssql_server.sqlserver.administrator_login_password # Required so that the password does not spill to console when the resource fails
    }
    command = "sqlcmd -U ${azurerm_mssql_server.sqlserver.administrator_login} -S ${azurerm_mssql_server.sqlserver.fully_qualified_domain_name} -d ${azurerm_mssql_database.sqldatabase.name} -i init_script.sql -o logsdb.txt"
  }
}