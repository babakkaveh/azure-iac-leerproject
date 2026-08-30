@description('Locatie voor de web app en het App Service Plan')
param location string = resourceGroup().location

@description('Omgeving: dev, test of prod')
param environment string = 'dev'

@description('SKU van het App Service Plan')
param sku string = 'F1'

@description('Naam van de Application Insights connection string app-setting; laat leeg om over te slaan')
param appInsightsConnectionString string = ''

var webAppName = toLower('app-${environment}-${uniqueString(resourceGroup().id)}')

resource appServicePlan 'Microsoft.Web/serverfarms@2023-12-01' = {
  name: 'plan-${environment}'
  location: location
  sku: {
    name: sku
    tier: sku == 'F1' ? 'Free' : 'Basic'
  }
  properties: {
    reserved: true
  }
}

resource webApp 'Microsoft.Web/sites@2023-12-01' = {
  name: webAppName
  location: location
  identity: {
    type: 'SystemAssigned'
  }
  properties: {
    serverFarmId: appServicePlan.id
    siteConfig: {
      linuxFxVersion: 'NODE|20-lts'
      appSettings: empty(appInsightsConnectionString) ? [] : [
        {
          name: 'APPLICATIONINSIGHTS_CONNECTION_STRING'
          value: appInsightsConnectionString
        }
      ]
    }
  }
  tags: {
    environment: environment
    project: 'azure-iac-leerproject'
  }
}

output webAppName string = webApp.name
output webAppUrl string = 'https://${webApp.properties.defaultHostName}'
output webAppPrincipalId string = webApp.identity.principalId
