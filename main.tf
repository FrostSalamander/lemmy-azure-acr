resource "azurerm_resource_group" "acr_rg" {
  name     = "acr-rg"
  location = var.location
}

resource "azurerm_container_registry" "acr" {
  name                = "897safsacr"
  resource_group_name = azurerm_resource_group.acr_rg.name
  location            = azurerm_resource_group.acr_rg.location
  sku                 = "Standard"
  admin_enabled       = false
  anonymous_pull_enabled = true
}

/*
resource "azurerm_user_assigned_identity" "acr_mi" {
  location            = azurerm_resource_group.acr_rg.location
  resource_group_name = azurerm_resource_group.acr_rg.name
  name                = "acr-mi"
}

resource "azurerm_role_assignment" "acr_mi_role_assignment" {
  scope                = azurerm_container_registry.acr.id
  role_definition_name = "AcrPull"
  principal_id         = azurerm_user_assigned_identity.acr_mi.principal_id
}
*/
