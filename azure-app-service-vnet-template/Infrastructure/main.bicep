targetScope = 'subscription'

param resource_group_name string = 'webapp-templates'
param location string = 'eastasia'

param app_service_plan_name string = 'webapp-template-app-plan'
param app_service_name string = 'webapp-template-app'

param sql_username string = 'sqlsrvdbadmin'
@secure()
param sql_password string

param tags object = {
  CreatedBy: 'azureinnovative@99x.io'
}

resource resource_group 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: resource_group_name
  location: location
  tags: tags
}

module vnet 'vnet.bicep' = {
  name: 'vnet'
  scope: resource_group
  params: {
    location: location
    tags: tags
  }
}

module app_service_plan 'app_service_plan.bicep' = {
  name: 'app_service_plan'
  scope: resource_group
  params: {
    app_service_plan_name: app_service_plan_name
    location: location
    tags: tags
  }
}

module app_service 'app_service.bicep' = {
  name: 'app_service'
  scope: resource_group
  params: {
    app_service_name: app_service_name
    location: location
    app_service_plan_id: app_service_plan.outputs.app_plan_id
    vnet_subnet_id: vnet.outputs.vnet_subnet_id
    tags: tags
  }
}

module sql 'azure_sql.bicep' = {
  name: 'sql'
  scope: resource_group
  params: {
    sql_username: sql_username
    sql_password: sql_password
    location: location
    vnet_subnet_id: vnet.outputs.vnet_subnet_id
    tags: tags
  }
}
