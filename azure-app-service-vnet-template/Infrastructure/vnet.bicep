param vnet_name string
param vnet_addr_prefixes array
param location string
param tags object

resource vnet 'Microsoft.Network/virtualNetworks@2022-01-01' = {
  name: vnet_name
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: vnet_addr_prefixes
    }
    subnets: [
      {
        name: 'todoappsubnet01'
        properties: {
          addressPrefix: '10.0.0.0/24'
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
    ]
  }
  tags: tags
}

output vnet_subnet_id string = vnet.properties.subnets[0].id
