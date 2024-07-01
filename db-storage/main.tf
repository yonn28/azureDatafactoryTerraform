/*

The following links provide the documentation for the new blocks used
in this terraform configuration file

1. azurerm_mssql_server - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/mssql_server

2. azurerm_mssql_database - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/mssql_database

*/

resource "azurerm_resource_group" "appgrp" {
  name     = var.resource_group_name
  location = var.location  
}


data "azurerm_client_config" "current" {
}

data "http" "currentip" {
  url = "https://ipv4.icanhazip.com"
}


resource "random_string" "random" {
  length = 6
  special = false
  upper = false
}

resource "azurerm_virtual_network" "netdb" {
  name                = "${random_string.random.result}-network"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.appgrp.location
  resource_group_name = azurerm_resource_group.appgrp.name
    depends_on = [
    azurerm_resource_group.appgrp
  ]
}

resource "azurerm_subnet" "subnetdb" {
  name                 = "${random_string.random.result}-subnet"
  resource_group_name  = azurerm_resource_group.appgrp.name
  virtual_network_name = azurerm_virtual_network.netdb.name
  address_prefixes       = ["10.0.1.0/24"]
  private_endpoint_network_policies  = "Enabled"
    depends_on = [
    azurerm_virtual_network.netdb
  ]
}

resource "azurerm_mssql_server" "sqlserver" {
  name                         = "sqlserver400908"
  resource_group_name          = azurerm_resource_group.appgrp.name
  location                     = azurerm_resource_group.appgrp.location
  version                      = "12.0"
  administrator_login          = var.administrator_login
  administrator_login_password = var.administrator_login_password 
  depends_on = [
    azurerm_resource_group.appgrp
  ]
}

resource "azurerm_private_endpoint" "conectionPrivate" {
  name                = "private-endpoint-sql"
  location            = azurerm_resource_group.appgrp.location
  resource_group_name = azurerm_resource_group.appgrp.name
  subnet_id           = azurerm_subnet.subnetdb.id

  private_service_connection {
    name                           = "private-serviceconnection"
    private_connection_resource_id = azurerm_mssql_server.sqlserver.id
    subresource_names              = [ "sqlServer" ]
    is_manual_connection           = false
  }

  private_dns_zone_group {
    name                 = "dns-zone-group"
    private_dns_zone_ids = [azurerm_private_dns_zone.my_terraform_dns_zone.id]
  }

  depends_on = [
    azurerm_mssql_server.sqlserver,
    azurerm_virtual_network.netdb
  ]
}


# Create private DNS zone
resource "azurerm_private_dns_zone" "my_terraform_dns_zone" {
  name                = "privatelink.database.windows.net"
  resource_group_name = azurerm_resource_group.appgrp.name
}

# Create virtual network link
resource "azurerm_private_dns_zone_virtual_network_link" "my_terraform_vnet_link" {
  name                  = "vnet-link"
  resource_group_name   = azurerm_resource_group.appgrp.name
  private_dns_zone_name = azurerm_private_dns_zone.my_terraform_dns_zone.name
  virtual_network_id    = azurerm_virtual_network.netdb.id
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

resource "azurerm_key_vault" "kv" {
  name                        = var.kev_vault_name
  location                    = azurerm_resource_group.appgrp.location
  resource_group_name         = azurerm_resource_group.appgrp.name
  enabled_for_disk_encryption = true
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false

  sku_name = "standard"

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    key_permissions = [
      "Get",
    ]

    secret_permissions = [
      "Set",
      "Get",
      "Delete",
      "Purge",
      "Recover",
      "List"
    ]

    storage_permissions = [
      "Get",
    ]
  }
}

resource "azurerm_key_vault_secret" "example" {
  name         = "DbPassword"
  value        = "Azure@3456"
  key_vault_id = azurerm_key_vault.kv.id
}