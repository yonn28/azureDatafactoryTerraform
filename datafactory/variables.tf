variable "resource_group_name" {
  type   = string
  default = "RG-factory"
}

variable "factory_name" {
  type        = string
  default     = "DF-pactice-25062024"
}

variable "integration_runtime_name" {
  type = string
  default = "integrationRuntimeForVirtualNetwork"
}

variable "kev_vault" {
  type = object({
    name = string
    resource_group_name = string
  })
  default = {
    name = "kvtest28062025"
    resource_group_name = "RG-factory"
  }
}

variable "storage_accounts" {
  type = list(object({
    name = string
    resource_group_name = string
  }))
  default = [{
    name = "vmst25062024"
    resource_group_name = "RG-factory"
  }]
}


variable "linked_service_blob_storages" {
  type = list(object({
    name = string
    storage_account_name = string
  }))
  default = [ {
    name = "storageLinkedService"
    storage_account_name = "vmst25062024"
  } ]
  
}

variable "custom_datasets" {
  type = list(object({
    name = string
    type = string
    description = string
    properties_file_path = string
    schema_file_path = string
    link_service_name = string
  }))
  default = [ {
    name = "InputDataset",
    type = "Excel"
    description = "excel export"
    properties_file_path = "inputDataset_properties.json"
    schema_file_path = "inputDataset_schema.json"
    link_service_name = "storageLinkedService"
  } ]
}

/******************* sql conection**********************/
variable "sql_datasets" {
    type = list(object({
    name = string
    table = string
  }))
  default = [ {
    name = "OutputDataset"
    table = "[dbo].[Movies]"
  } ]
}
/******************* sql conection**********************/

/********************** database manager conection string ****************/
# variable "managed_instance_conection" {
#   type = object({
#     source = string
#     databse_name = string 
#     admin_login = string
#   })
#   default = {
#     source = "value"
#     databse_name = ""
#     admin_login = ""
#   }
# }

/********************** database manager conection string ****************/

variable "triggers_blob_events" {
  type = list(object({
    name = string
    blob_path_begins = string
    blob_path_ends_with = string
    pipleline_name = string
    storage_account_name = string
  }))
  default = [ {
    name = "triggerUpdate" 
    blob_path_begins = "/data/"
    blob_path_ends_with = ".xlsx"
    pipleline_name = "updateMoviesSQLPipeline"
    storage_account_name = "vmst25062024"
  } ]
}


variable "pipelines" {
  type = list(object({
    name = string
    activities_file_path = string
    description = string
  }))
  default = [ {
    name = "updateMoviesSQLPipeline"
    activities_file_path = "pipeline.json"
    description = "Pipeline to copy xls to azure sql"
  } ]
}