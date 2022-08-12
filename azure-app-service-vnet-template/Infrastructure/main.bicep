targetScope='subscription'

param resource_group_name string = 'webapp-templates'
param location string = 'southeastasia'
param app_service_plan_name string = 'webapp-template-app-plan'
param app_service_name string = 'webapp-template-app'
param sku string = 'B1'
param linux_fx_version string = 'DOTNETCORE:6.0'
param tags object = {
  CreatedBy:'sachiths@99x.io'
}


resource resource_group 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: resource_group_name
  location: location
  tags:tags
}

module app_service_plan 'app_service_plan.bicep' = {
  name: 'app_service_plan'
  scope: resource_group
  params:{
    app_service_plan_name: app_service_plan_name
    location: location
    sku: sku
    tags:tags
  }
}


module app_service 'app_service.bicep' = {
  name: 'app_service'
  scope: resource_group
  params:{
    app_service_name: app_service_name
    location: location
    app_service_plan_id: app_service_plan.outputs.app_plan_id
    linux_fx_version: linux_fx_version
    tags:tags
  }
}
