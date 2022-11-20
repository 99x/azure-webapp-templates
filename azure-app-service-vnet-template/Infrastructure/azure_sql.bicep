param sql_server_name string
param sql_db_name string
param location string
param sku_name string
param sku_tier string
param vnet_subnet_id string
param tags object

resource sql_server 'Microsoft.Sql/servers@2022-02-01-preview' = {
  name: sql_server_name
  location: location
  properties: {
    administratorLogin: 'sqlsrvdbadmin'
    administratorLoginPassword: 'SqlDbAdmin@2022'
  }
  identity: {
    type: 'SystemAssigned'
  }
  tags: tags
}

resource sql_db 'Microsoft.Sql/servers/databases@2022-02-01-preview' = {
  parent: sql_server
  name: sql_db_name
  location: location
  sku: {
    name: sku_name
    tier: sku_tier
  }
  properties: {
    collation: 'SQL_Latin1_General_CP1_CI_AS'
    zoneRedundant: false
  }
  tags: tags
}

resource vnet_rule 'Microsoft.Sql/servers/virtualNetworkRules@2022-02-01-preview' = {
  name: '${sql_server_name}/allowVnetRule'
  properties: {
    virtualNetworkSubnetId: vnet_subnet_id
  }
  tags: tags
}
