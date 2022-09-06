param app_service_name string
param location string
param app_service_plan_id string
param linux_fx_version string
param tags object

resource app_service 'Microsoft.Web/sites@2022-03-01' = {
  name: app_service_name
  location: location
  properties: {
    serverFarmId: app_service_plan_id
    siteConfig: {
      linuxFxVersion: linux_fx_version
    }
  }
  identity:{
    type:'SystemAssigned'
  }
  tags:tags
}

output principal_id string = app_service.identity.principalId
