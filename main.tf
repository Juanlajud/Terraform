// declaring provider. Azure
  provider "azurerm" {
    features {}
  }

// declaring provider version, before, I just included the version in the provider declaration, but getting a warning: 
//"Version constraints inside provider configuration blocks are deprecated"
// after investigation, found this new way of declaring provider version

terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "2.71.0"
    } 
  }
}

// creating variables.tf file in order to make changes easier. using this global variables can be overriden using .tfvars file

resource "azurerm_resource_group" "JWA" {
  name     = var.rg_name
  location = var.location
}

resource "azurerm_app_service_plan" "JWA" {
  name                = var.app_srvc_plan_name
  location            = azurerm_resource_group.JWA.location
  resource_group_name = azurerm_resource_group.JWA.name
sku {
    tier = "Basic"
    size = "B1"
  }
}

resource "azurerm_app_service" "JWA" {
  name                = var.app_srvc_name
  location            = azurerm_resource_group.JWA.location
  resource_group_name = azurerm_resource_group.JWA.name
  app_service_plan_id = azurerm_app_service_plan.JWA.id




  site_config {
    dotnet_framework_version = "v4.0"
    scm_type                 = "LocalGit"
  }

  app_settings = {
    "KEY" = "AzureCloudSecretKey123"
  }

  connection_string {
    name  = "Database"
    type  = "SQLServer"
    value = "Server=tcp:azurerm_sql_server.sqldb.fully_qualified_domain_name Database=azurerm_sql_database.db.name;User ID=azurerm_sql_server.sqldb.administrator_login;Password=azurerm_sql_server.sqldb.administrator_login_password;Trusted_Connection=False;Encrypt=True;"
  }
}

resource "azurerm_sql_server" "sqldb" {
  name                         = var.sql_server_name
  resource_group_name          = azurerm_resource_group.JWA.name
  location                     = azurerm_resource_group.JWA.location
  version                      = "12.0"
  administrator_login          = var.sql_admin_login
  administrator_login_password = var.sql_admin_password
}

resource "azurerm_sql_database" "db" {
  name                = var.sql_database_name
  resource_group_name = azurerm_resource_group.JWA.name
  location            = azurerm_resource_group.JWA.location
  server_name         = azurerm_sql_server.sqldb.name
}

