//link to movies file download https://gist.github.com/tiangechen/b68782efa49a16edaf07dc2cdaa855ea

resource "azurerm_storage_account" "vmst25062024" {
  name                     = "vmst25062024"
  resource_group_name      = azurerm_resource_group.appgrp.name
  location                 = "North Europe"
  account_tier             = "Standard"
  account_replication_type = "LRS"
  account_kind = "StorageV2"  
  depends_on = [
    azurerm_resource_group.appgrp
  ]
}

resource "azurerm_storage_container" "data" {
  name                  = "data"
  storage_account_name  = "vmst25062024"
  container_access_type = "blob"
  depends_on=[
    azurerm_storage_account.vmst25062024
    ]
}



resource "azurerm_storage_blob" "moviesField" {
  name                   = "movies.csv"
  storage_account_name   = "vmst25062024"
  storage_container_name = "data"
  type                   = "Block"
  source                 = "movies.csv"
   depends_on=[azurerm_storage_container.data,
    azurerm_storage_account.vmst25062024]
}