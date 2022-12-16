param sql_username string
@secure()
param sql_password string
param location string
param vnet_subnet_id string
param tags object

var sql_server_name = 'todoappsql01'

resource sql_server 'Microsoft.Sql/servers@2022-02-01-preview' = {
  name: sql_server_name
  location: location
  properties: {
    administratorLogin: sql_username
    administratorLoginPassword: sql_password
  }
  identity: {
    type: 'SystemAssigned'
  }
  tags: tags
}

resource sql_db 'Microsoft.Sql/servers/databases@2022-02-01-preview' = {
  parent: sql_server
  name: 'todoappsqldb01'
  location: location
  sku: {
    name: 'Basic'
    tier: ''
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
