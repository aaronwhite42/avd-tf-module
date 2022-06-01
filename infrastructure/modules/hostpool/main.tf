#-------------------------------------------------
# Azure Virtual Desktop module
#-------------------------------------------------
terraform {
  experiments = [module_variable_optional_attrs]
}

resource "time_rotating" "wvd_token" {
  rotation_days = 30
}


#AVD Host Pool
resource "azurerm_virtual_desktop_host_pool" "avd_host_pool" {
  resource_group_name      = var.resource_group_name
  name                     = var.host_pool_name
  location                 = var.avdservice_region == null ? "eastus2" : var.avdservice_region
  friendly_name            = var.friendly_name
  description              = var.description
  validate_environment     = var.validate_environment
  custom_rdp_properties    = var.custom_rdp_properties
  type                     = var.host_pool_type == null ? "Pooled" : var.host_pool_type
  maximum_sessions_allowed = var.max_sessions
  load_balancer_type       = var.load_balancer_type == null ? "BreadthFirst" : var.load_balancer_type
}


resource "azurerm_virtual_desktop_host_pool_registration_info" "registration_info" {
  hostpool_id     = azurerm_virtual_desktop_host_pool.avd_host_pool.id
  expiration_date = time_rotating.wvd_token.rotation_rfc3339
}

# Application Group
# resource "azurerm_virtual_desktop_application_group" "desktop" {
#   name                = var.desktopapp_name
#   location            = var.wvdservice_region
#   resource_group_name = var.resource_group_name
#   type                = "Desktop"
#   host_pool_id        = azurerm_virtual_desktop_host_pool.desktop.id
#   friendly_name       = var.desktopapp_friendlyname
#   description         = var.desktopapp_description
# }



#Associate Desktop application Group with Main Workspace
# resource "azurerm_virtual_desktop_workspace_application_group_association" "workspacedesktop" {
#   workspace_id         = azurerm_virtual_desktop_workspace.main.id
#   application_group_id = azurerm_virtual_desktop_application_group.desktop.id
# }
