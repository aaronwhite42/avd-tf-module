#-------------------------------------------------
# Terraform Infrastructure
#-------------------------------------------------
terraform {
  required_version = ">= 1.1.9"
  # backend "azurerm" {}
  required_providers {
    azurerm = {
    }
  }
  experiments = [module_variable_optional_attrs]
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "rg" {
  name     = "aw-avd-rg"
  location = "eastus2"
}

# Add your Terraform resource declarations here

resource "azurerm_virtual_desktop_workspace" "main" {
  name                = "aw-avd-ws"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  friendly_name       = "Main Workspace"
  description         = "Description goes here"
  tags = {
    CostCentre = "314159"
  }
}

# Create a single hostpool using explicit values
module "hostpool-ex1" {
  source              = "./modules/hostpool"
  resource_group_name = azurerm_resource_group.rg.name
  host_pool_name      = "aw-hostpool-1"
  friendly_name       = "AW Test pool"
  description         = "Description goes here"
}

# Create multiple hostpools using data-driven approach, using data from 'terraform.tfvars'
module "hostpool-ex2" {
  source = "./modules/hostpool"

  for_each              = var.host_pools
  resource_group_name   = azurerm_resource_group.rg.name
  host_pool_name        = each.key
  friendly_name         = each.value.friendly_name
  description           = each.value.description
  avdservice_region     = each.value.avdservice_region
  custom_rdp_properties = each.value.custom_rdp_properties
  max_sessions          = each.value.max_sessions
  host_pool_type        = each.value.host_pool_type
  load_balancer_type    = each.value.load_balancer_type
  validate_environment  = each.value.validate_environment
}
