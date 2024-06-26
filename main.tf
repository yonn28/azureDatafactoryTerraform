resource "azurerm_resource_group" "appgrp" {
  name     = var.resource_group_name
  location = var.location  
}


resource "azurerm_data_factory" "df" {
  name                = var.factory_name
  location            = azurerm_resource_group.appgrp.location
  resource_group_name = azurerm_resource_group.appgrp.name
}

resource "azurerm_data_factory_linked_service_azure_blob_storage" "storage" {
  name                = "storageLinkedService"
  data_factory_id   = azurerm_data_factory.df.id
  connection_string = azurerm_storage_account.vmst25062024.primary_connection_string
  depends_on = [ azurerm_data_factory.df ]
}

resource "azurerm_data_factory_dataset_azure_blob" "input_dataset" {
  name                = "InputDataset"
  data_factory_id   = azurerm_data_factory.df.id
  linked_service_name = azurerm_data_factory_linked_service_azure_blob_storage.storage.name
  path     = "data"
  filename   = "movies.csv"
  depends_on = [ azurerm_data_factory_linked_service_azure_blob_storage.storage ]
}

resource "azurerm_data_factory_linked_service_azure_sql_database" "sql" {
  name              = "sqlLinkedService"
  data_factory_id   = azurerm_data_factory.df.id
  connection_string = "Server=tcp:${azurerm_mssql_server.sqlserver.fully_qualified_domain_name},1433;Initial Catalog=${azurerm_mssql_database.sqldatabase.name};Persist Security Info=False;User ID=${azurerm_mssql_server.sqlserver.administrator_login};Password=${azurerm_mssql_server.sqlserver.administrator_login_password};MultipleActiveResultSets=False;Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;"
  depends_on = [ azurerm_data_factory.df ]
}



resource "azurerm_data_factory_dataset_azure_sql_table" "output_dataset" {
  name                = "OutputDataset"
  data_factory_id   = azurerm_data_factory.df.id
  table = "[dbo].[Movies]" // added for configure target table
  linked_service_id = azurerm_data_factory_linked_service_azure_sql_database.sql.id
  depends_on = [  
        azurerm_data_factory_linked_service_azure_sql_database.sql 
  ]
}


resource "azurerm_data_factory_pipeline" "example_pipeline" {
  name                = "updateCSVPipeline"
  data_factory_id   = azurerm_data_factory.df.id
  description         = "Pipeline to copy data and execute stored procedure."
  variables = {
    "bob" = "item1"
  }
  activities_json = data.local_file.pipeline_config.content

  depends_on = [ 
    azurerm_data_factory_dataset_azure_blob.input_dataset, 
    azurerm_data_factory_dataset_azure_sql_table.output_dataset 
  ]

}

data "local_file" "pipeline_config" {
  filename = "pipeline.json"
}