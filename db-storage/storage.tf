//link to movies file download https://gist.github.com/tiangechen/b68782efa49a16edaf07dc2cdaa855ea

resource "azurerm_storage_account" "vmst25062024" {
  name                     = var.storage_name
  resource_group_name      = azurerm_resource_group.appgrp.name
  location                 = azurerm_resource_group.appgrp.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  account_kind = "StorageV2"  
  depends_on = [
    azurerm_resource_group.appgrp
  ]
}

resource "azurerm_storage_container" "data" {
  name                  = "data"
  storage_account_name  = azurerm_storage_account.vmst25062024.name
  container_access_type = "blob"
  depends_on=[
    azurerm_storage_account.vmst25062024
    ]
}



resource "azurerm_storage_blob" "moviesField" {
  name                   = "movies.xlsx"
  storage_account_name   = azurerm_storage_account.vmst25062024.name
  storage_container_name = azurerm_storage_container.data.name
  type                   = "Block"
  source                 = "movies.xlsx"
   depends_on=[azurerm_storage_container.data,
    azurerm_storage_account.vmst25062024]
}