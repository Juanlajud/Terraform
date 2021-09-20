variable "rg_name" {
    default = "JUMBO_WEB_APP"
    type = string
    description = "rg name"
}

variable "location" {
    default = "eastUS"
    type = string
    description = "location"
}

/*
variable "environment" {
  type = string
  description = "Environment (test / stage / prod)"
}

variable "app_srvc_plan_name" {
    default = "JumboAppServicePlan"
    type = string
    description = "App Service Plan name"
}

variable "app_srvc_name" {
    default = "JumboAppService"
    type = string
    description = "App Service name"
}

variable "sql_server_name" {
  default = "sqlserverlajud123"
  type        = string
  description = "SQL Server instance name"
}

variable "sql_database_name" {
  default = "sqldblajud123"
  type        = string
  description = "SQL Database name"
}

variable "sql_admin_login" {
  type        = string
  description = "SQL Server login"
}

variable "sql_admin_password" {
  type        = string
  description = "SQL Server password"
}

*/