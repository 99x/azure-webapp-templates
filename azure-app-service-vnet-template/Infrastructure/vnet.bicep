param location string
param tags object

resource vnet 'Microsoft.Network/virtualNetworks@2022-01-01' = {
  name: 'todoappvnet01'
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [ '10.0.0.0/16' ]
    }
    subnets: [
      {
        name: 'appservicesubnet'
        properties: {
          addressPrefix: '10.0.1.0/24'
          serviceEndpoints: [
            {
              service: 'Microsoft.Sql'
            }
          ]
          delegations: [
            {
              name: 'delegation'
              properties: {
                serviceName: 'Microsoft.Web/serverFarms'
              }
            }
          ]
        }
      }
      {
        name: 'databasesubnet'
        properties: {
          addressPrefix: '10.0.2.0/24'
          delegations: [
            {
              name: 'delegation'
              properties: {
                serviceName: 'Microsoft.Sql'
              }
            }
          ]
        }
      }
    ]
  }
  tags: tags
}

output vnet_subnet_id string = vnet.properties.subnets[0].id
