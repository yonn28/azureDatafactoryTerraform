variable "resource_group_name" {
  type   = string
  default = "RG-factory"
}
variable "location" {
  type    = string
  default = "eastus"
}

variable "storage_name" {
  type = string
  default = "vmst25062024"
}

variable "administrator_login" {
    type = string
    default = "sqladmin"
}
variable "administrator_login_password" {
    type = string
    default = "Azure@3456"
}


variable "kev_vault_name" {
  type = string
  default = "kvtest28062025"
}