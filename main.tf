resource "azurerm_resource_group" "appgrp" {
  name     = var.resource_group_name
  location = var.location  
}


resource "azurerm_data_factory" "df" {
  name                = var.factory_name
  location            = azurerm_resource_group.appgrp.location
  resource_group_name = azurerm_resource_group.appgrp.name
  managed_virtual_network_enabled = true // agreagar para no error integration runtime
}


resource "azurerm_data_factory_integration_runtime_azure" "integrationVitualNet" {
  name            = "integrationRuntimeForVirtualNetwork"
  data_factory_id = azurerm_data_factory.df.id
  location        = azurerm_resource_group.appgrp.location
  virtual_network_enabled = true // support private endpoints config
  depends_on = [ azurerm_data_factory.df ]
}

resource "azurerm_data_factory_managed_private_endpoint" "azureSqlPrivateEndpoint" {
  name               = "azureSqlPrivateEndpoint"
  data_factory_id    = azurerm_data_factory.df.id
  target_resource_id = azurerm_mssql_server.sqlserver.id
  subresource_name   = "sqlServer"// cambiar por managedInstance
  depends_on = [ 
    azurerm_data_factory.df,
    azurerm_data_factory_integration_runtime_azure.integrationVitualNet,
    azurerm_private_endpoint.conectionPrivate
   ]
}

resource "azurerm_data_factory_linked_service_azure_blob_storage" "storage" {
  name                = "storageLinkedService"
  data_factory_id   = azurerm_data_factory.df.id
  connection_string = azurerm_storage_account.vmst25062024.primary_connection_string
  depends_on = [ azurerm_data_factory.df ]
}


resource "azurerm_data_factory_linked_service_azure_sql_database" "sql" {
  name              = "sqlLinkedService"
  data_factory_id   = azurerm_data_factory.df.id
  connection_string = "Server=tcp:${azurerm_mssql_server.sqlserver.fully_qualified_domain_name},1433;Initial Catalog=${azurerm_mssql_database.sqldatabase.name};Persist Security Info=False;User ID=${azurerm_mssql_server.sqlserver.administrator_login};Password=${azurerm_mssql_server.sqlserver.administrator_login_password};MultipleActiveResultSets=False;Encrypt=False;TrustServerCertificate=False;Connection Timeout=30;"
  integration_runtime_name = azurerm_data_factory_integration_runtime_azure.integrationVitualNet.name
  depends_on = [ 
    azurerm_data_factory.df, 
    azurerm_data_factory_integration_runtime_azure.integrationVitualNet 
  ]
}

resource "azurerm_data_factory_custom_dataset" "input_dataset" {
  count = length(var.input_dataset)  
  name            = var.input_dataset[count.index].name
  data_factory_id = azurerm_data_factory.df.id
  type            = "Excel"
  linked_service {
    name = azurerm_data_factory_linked_service_azure_blob_storage.storage.name
  }

  type_properties_json = file("${var.input_dataset[count.index].properties_file_path}")

  description = "excel config"
  schema_json = file("${var.input_dataset[count.index].schema_file_path}")


  depends_on = [ azurerm_data_factory_linked_service_azure_blob_storage.storage ]
}



resource "azurerm_data_factory_dataset_azure_sql_table" "output_dataset" {
  name                = "OutputDataset"
  data_factory_id   = azurerm_data_factory.df.id
  table = "[dbo].[Movies]" 
  linked_service_id = azurerm_data_factory_linked_service_azure_sql_database.sql.id
  depends_on = [  
        azurerm_data_factory_linked_service_azure_sql_database.sql 
  ]
}

resource "azurerm_data_factory_trigger_blob_event" "triggerUpdate" {
  name                = "triggerUpdate"
  data_factory_id     = azurerm_data_factory.df.id
  storage_account_id  = azurerm_storage_account.vmst25062024.id // saaeuecpprdpaccionistas, saaeuecpprdpaccionistas
  events              = ["Microsoft.Storage.BlobCreated"]
  blob_path_begins_with = "/data/"  // cambiar por /derechospreferencia/DerechosPreferencia , /actualizacionautomatica/
  blob_path_ends_with = ".xlsx"
  ignore_empty_blobs  = true
  activated           = true
  pipeline {
    name = azurerm_data_factory_pipeline.example_pipeline[0].name

  }
}

resource "azurerm_data_factory_pipeline" "example_pipeline" {
  count = length(var.pipelines)
  name                = "${var.pipelines[count.index].name}"
  data_factory_id   = azurerm_data_factory.df.id
  description         = "Pipeline to copy xls to azure sql"

  activities_json = file("${var.pipelines[count.index].activities_file_path}")

  depends_on = [ 
    azurerm_data_factory_custom_dataset.input_dataset, 
    azurerm_data_factory_dataset_azure_sql_table.output_dataset 
  ]

}
