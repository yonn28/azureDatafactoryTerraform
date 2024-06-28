variable "resource_group_name" {
  type   = string
  default = "RG-factory"
}
variable "location" {
  type    = string
  default = "eastus"
}

variable "factory_name" {
  type        = string
  description = "Data Factory name"
  default     = "DF-pactice-25062024"
}

variable "data_factory_location" {
  type    = string
  default = "eastus"
}

//

variable "administrator_login" {
    type = string
    default = "sqladmin"
}
variable "administrator_login_password" {
    type = string
    default = "Azure@3456"
}

variable "input_dataset" {
  type = list(object({
    name = string
    properties_file_path = string
    schema_file_path = string
  }))
  default = [ {
    name = "InputDataset",
    properties_file_path = "inputDataset_properties.json"
    schema_file_path = "inputDataset_schema.json"
  } ]
}


variable "pipelines" {
  type = list(object({
    name = string
    activities_file_path = string
  }))
  default = [ {
    name = "updateMoviesSQLPipeline"
    activities_file_path = "pipeline.json"
  } ]
}