param app_service_plan_name string
param location string
param sku string
param tags object

resource app_service_plan 'Microsoft.Web/serverfarms@2022-03-01' = {
  name: app_service_plan_name
  location: location
  properties: {
    reserved: true
  }
  sku: {
    name: sku
  }
  kind: 'linux'
  tags:tags
}

output app_plan_id string = app_service_plan.id
