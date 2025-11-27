
output "web_app_default_hostname" {
  value = azurerm_app_service.app.default_site_hostname
}

output "resource_group_name" {
  value = azurerm_resource_group.rg.name
}

output "container_registry_login_server" {
  value = azurerm_container_registry.acr.login_server
}

output "bastion_hostname" {
  value = azurerm_bastion_host.bastion.name
}
