# We strongly recommend using the required_providers block to set the
# Azure Provider source and version being used
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=2.46.0"
    }
  }
}

provider "azurerm" {    
    features {}
}

terraform {
    backend "azurerm" {
      resource_group_name  = "tf_rg_blobstore"
      storage_account_name = "tfstorageaccountdigic"
      container_name       = "tfstate"
      key                  = "terraform.tfstate"
    }    
}


resource "azurerm_resource_group" "tf_test" {
    name = "tfmainrg"
    location = "UK West"
}

resource "azurerm_container_group" "tfcg_test" {
    name                = "weatherapi"
    location            = azurerm_resource_group.tf_test.location
    resource_group_name = azurerm_resource_group.tf_test.name

    ip_address_type         = "public"
    dns_name_label          = "digicwebapi"
    os_type                 = "Linux"
     container {
      name            = "weatherapi"
      image           = "digic/weatherapi"
        cpu             = "1"
        memory          = "1"

        ports {
            port        = 80
            protocol    = "TCP"
        }
  }
}