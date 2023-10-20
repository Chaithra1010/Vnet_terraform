terraform {
  required_providers {
    azurerm = {
     source = "hashicorp/azurerm"
     version = "3.38.0"
  }
}
}

terraform {
  backend "azurerm" {
    resource_group_name = "chaithratestrg"
    storage_account_name = "chaithratestrg"
    container_name = "tfstate1"
    key = "terraform.tfstate"
    
  }
}




resource "azurerm_resource_group" "example" {
  name     = "example-resources"
  location = "West Europe"
}
 
resource "azurerm_dev_test_lab" "example" {
  name                = "example-devtestlab"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
 
  tags = {
    "Sydney" = "Australia"
  }
}
 
resource "azurerm_dev_test_virtual_network" "example" {
  name                = "example-network"
  lab_name            = azurerm_dev_test_lab.example.name
  resource_group_name = azurerm_resource_group.example.name
 
  subnet {
    use_public_ip_address           = "Allow"
    use_in_virtual_machine_creation = "Allow"
  }
}
