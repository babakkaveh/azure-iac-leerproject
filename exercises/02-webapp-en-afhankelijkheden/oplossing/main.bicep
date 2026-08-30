param location string = resourceGroup().location
param environment string = 'dev'

var webAppName = toLower('app-${environment}-${uniqueString(resourceGroup().id)}')

resource appServicePlan 'Microsoft.Web/serverfarms@2023-12-01' = {
  name: 'plan-${environment}'
  location: location
  sku: {
    name: 'F1'
    tier: 'Free'
  }
  properties: {
    reserved: true
  }
}

resource webApp 'Microsoft.Web/sites@2023-12-01' = {
  name: webAppName
  location: location
  properties: {
    serverFarmId: appServicePlan.id
    siteConfig: {
      linuxFxVersion: 'NODE|20-lts'
    }
  }
  tags: {
    environment: environment
    project: 'azure-iac-leerproject'
  }
}

output webAppUrl string = 'https://${webApp.properties.defaultHostName}'
