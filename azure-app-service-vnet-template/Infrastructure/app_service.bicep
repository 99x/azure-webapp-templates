param app_service_name string
param location string
param app_service_plan_id string
param vnet_subnet_id string
param tags object

resource app_service 'Microsoft.Web/sites@2022-03-01' = {
  name: app_service_name
  location: location
  properties: {
    serverFarmId: app_service_plan_id
    virtualNetworkSubnetId: vnet_subnet_id
    siteConfig: {
      linuxFxVersion: 'DOTNETCORE:6.0'
      vnetRouteAllEnabled: true
      http20Enabled: true
    }
  }
  identity:{
    type:'SystemAssigned'
  }
  tags:tags
}

output principal_id string = app_service.identity.principalId
