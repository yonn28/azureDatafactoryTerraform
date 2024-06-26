variable "resource_group_name" {
  type   = string
  default = "RG-factory"
}
variable "location" {
  type        = string
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

