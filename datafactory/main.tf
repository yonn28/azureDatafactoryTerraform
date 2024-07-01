
data "azurerm_resource_group" "appgrp" {
  name = var.resource_group_name
}

data "azurerm_key_vault" "kv" {
  name                = var.kev_vault.name
  resource_group_name = var.kev_vault.resource_group_name
}

data "azurerm_storage_account" "storages" {
  for_each = { for storage in var.storage_accounts: storage.name => storage}
  name                = each.value.name
  resource_group_name = each.value.resource_group_name
}


# data "azurerm_mssql_managed_instance" "example" {
#   name                = "mi-asc-ecp-prdmainsqlmiprd4"
#   resource_group_name = azurerm_resource_group.example.name
# }

/******************* sql conection**********************/
data "azurerm_mssql_server" "sqlserver" {
  name                = "sqlserver400908"
  resource_group_name = var.resource_group_name
}

data "azurerm_mssql_database" "sqldatabase" {
  name      = "sqldatabase"
  server_id = data.azurerm_mssql_server.sqlserver.id
}

/******************* sql conection**********************/

resource "azurerm_data_factory" "df" {
  name                = var.factory_name
  location            = data.azurerm_resource_group.appgrp.location
  resource_group_name = data.azurerm_resource_group.appgrp.name
  managed_virtual_network_enabled = true // agreagar para no error integration runtime
  identity {
    type = "SystemAssigned"
  }
}


resource "azurerm_data_factory_integration_runtime_azure" "integrationVitualNet" {
  name            = var.integration_runtime_name
  data_factory_id = azurerm_data_factory.df.id
  location        = data.azurerm_resource_group.appgrp.location
  virtual_network_enabled = true // support private endpoints config
  depends_on = [ azurerm_data_factory.df ]
}

resource "azurerm_data_factory_managed_private_endpoint" "azureSqlPrivateEndpoint" {
  name               = "azureSqlPrivateEndpoint"
  data_factory_id    = azurerm_data_factory.df.id
  target_resource_id = data.azurerm_mssql_server.sqlserver.id //cambiar por el managed instance
  subresource_name   = "sqlServer"// cambiar por managedInstance
  depends_on = [ 
    azurerm_data_factory.df,
    azurerm_data_factory_integration_runtime_azure.integrationVitualNet,
   ]
}

resource "azurerm_data_factory_linked_service_key_vault" "kv_link" {
  name            = "AzureKeyVaultAccionistas"
  data_factory_id = azurerm_data_factory.df.id
  key_vault_id    = data.azurerm_key_vault.kv.id
}

resource "azurerm_data_factory_linked_service_azure_blob_storage" "storage" {
  for_each = { for link in var.linked_service_blob_storages: link.name => link }
  name                =  each.value.name
  data_factory_id   = azurerm_data_factory.df.id
  connection_string = data.azurerm_storage_account.storages[each.value.storage_account_name].primary_connection_string
  depends_on = [ azurerm_data_factory.df ]
}



/*****************sql conection **********************/
resource "azurerm_data_factory_linked_service_azure_sql_database" "sql" {
  name              = "sqlLinkedService"
  data_factory_id   = azurerm_data_factory.df.id
  # connection_string = "Server=tcp:${data.azurerm_mssql_server.sqlserver.fully_qualified_domain_name},1433;Initial Catalog=${data.azurerm_mssql_database.sqldatabase.name};Persist Security Info=False;User ID=${data.azurerm_mssql_server.sqlserver.administrator_login} ;MultipleActiveResultSets=False;Encrypt=False;TrustServerCertificate=False;Connection Timeout=30;"
  connection_string = "Integrated Security=False;Encrypt=True;Connection Timeout=30;Data Source=${data.azurerm_mssql_server.sqlserver.fully_qualified_domain_name};Initial Catalog=${data.azurerm_mssql_database.sqldatabase.name};User ID=${data.azurerm_mssql_server.sqlserver.administrator_login}"
  integration_runtime_name = azurerm_data_factory_integration_runtime_azure.integrationVitualNet.name

  key_vault_password {
    linked_service_name = "AzureKeyVaultAccionistas"
    secret_name = "DbPassword"
  }
  depends_on = [ 
    azurerm_data_factory.df, 
    azurerm_data_factory_integration_runtime_azure.integrationVitualNet,
    azurerm_data_factory_linked_service_key_vault.kv_link
  ]
}
/*************************sql conection***********************************/


/************************** database manager conection string ****************************/
# resource "azurerm_data_factory_linked_custom_service" "custom" {
#   data_factory_id = azurerm_data_factory.df.id
#   name            = "AzureSqlMIPrd4"
#   type            = "AzureSqlMI"
#   description          = "test description"
#   type_properties_json = <<JSON
#   {
#     "connectionString":"Integrated Security=False;Encrypt=True;Connection Timeout=30;Data Source=${var.managed_instance_conection.source},1433;Initial Catalog=${var.managed_instance_conection.databse_name};User ID=${var.managed_instance_conection.admin_login}"
#       "password": {
#          "type": "AzureKeyVaultSecret",
#           "store": {
#              "referenceName": "AzureKeyVaultAccionistas",
#              "type": "LinkedServiceReference"
#           },
#           "secretName": "DbPassword"
#        }
#   }
#   JSON
#   integration_runtime {
#     name = azurerm_data_factory_integration_runtime_azure.integrationVitualNet.name
#   }
#   depends_on = [ 
#     azurerm_data_factory.df, 
#     azurerm_data_factory_integration_runtime_azure.integrationVitualNet,
#     azurerm_data_factory_linked_service_key_vault.kv_link
#   ]
# }

/************************** database manager conection string ****************************/

resource "azurerm_data_factory_custom_dataset" "custom_datasets" {
  for_each = { for dataset in var.custom_datasets : dataset.name => dataset}
  name            = each.value.name
  data_factory_id = azurerm_data_factory.df.id
  type            = each.value.type
  linked_service {
    name = each.value.link_service_name
  }

  type_properties_json = file("${each.value.properties_file_path}")

  description = each.value.description
  schema_json = file("${each.value.schema_file_path}")


  depends_on = [ azurerm_data_factory_linked_service_azure_blob_storage.storage ]
}


/******************* sql conection**********************/
resource "azurerm_data_factory_dataset_azure_sql_table" "output_dataset" {
  for_each = {for dataset in var.sql_datasets: dataset.name => dataset}
  name                =  each.value.name
  data_factory_id   = azurerm_data_factory.df.id
  table = each.value.table
  linked_service_id = azurerm_data_factory_linked_service_azure_sql_database.sql.id
  depends_on = [  
        azurerm_data_factory_linked_service_azure_sql_database.sql 
  ]
}
/******************* sql conection**********************/

resource "azurerm_data_factory_trigger_blob_event" "triggerUpdate" {
  for_each = {for trigger in var.triggers_blob_events: trigger.name => trigger}
  name                = each.value.name
  data_factory_id     = azurerm_data_factory.df.id
  storage_account_id  = data.azurerm_storage_account.storages[each.value.storage_account_name].id // saaeuecpprdpaccionistas, saaeuecpprdpaccionistas
  events              = ["Microsoft.Storage.BlobCreated"]
  blob_path_begins_with = each.value.blob_path_begins  // cambiar por /derechospreferencia/DerechosPreferencia , /actualizacionautomatica/
  blob_path_ends_with = each.value.blob_path_ends_with
  ignore_empty_blobs  = true
  activated           = true
  pipeline {
    name = azurerm_data_factory_pipeline.pipelines[each.value.pipleline_name].name
  }
}

resource "azurerm_data_factory_pipeline" "pipelines" {
  for_each = { for pipeline in var.pipelines: pipeline.name => pipeline }
  name                = each.value.name
  data_factory_id   = azurerm_data_factory.df.id
  description         = each.value.description

  activities_json = file("${each.value.activities_file_path}")

  depends_on = [ 
    azurerm_data_factory_custom_dataset.custom_datasets, 
    azurerm_data_factory_dataset_azure_sql_table.output_dataset
  ]

}
