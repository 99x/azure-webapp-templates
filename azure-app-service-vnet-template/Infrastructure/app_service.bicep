param app_service_name string
param location string
param app_service_plan_id string
param vnet_subnet_id string
param tags object
param sql_username string
@secure()
param sql_password string
param sql_server_name string
param sql_db_name string

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

resource app_service_connection_string 'Microsoft.Web/sites/config@2022-03-01' = {
  name: 'connectionstrings'
  kind: 'string'
  parent: app_service
  properties: {
    connection_string:{
      value: format('Server=tcp:{0}1433;Initial Catalog={1};Persist Security Info=False;User ID={2};Password={3};MultipleActiveResultSets=False;Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;',sql_server_name, sql_db_name, sql_username, sql_password)
      type: 'SQLAzure'
    }
  }
}

output principal_id string = app_service.identity.principalId
