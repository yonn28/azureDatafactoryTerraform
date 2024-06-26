

export from azure a resource

``` 
aztfexport resource --non-interactive --hcl-only **********
```


missing provider.tf file for integration with azure devops, look you need the azurerm for write the tfstate files into the storage account.

```
terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "3.106.1"
    }
  }
  backend "azurerm" {}
}

provider "azurerm" {
    subscription_id = "xxxxxx"
    features {}
}


 ``` 

 for local deployment use the following using App registrations in entra, and register in subscription and assing the role for contributor use the following pattern replace the missing information.

 ```
 terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "3.106.1"
    }
  }
}

provider "azurerm" {
    subscription_id = "xxx"
    tenant_id = "xx"
    client_id = "xxxx"
    client_secret = "xxx"
    features {}
}
 ```