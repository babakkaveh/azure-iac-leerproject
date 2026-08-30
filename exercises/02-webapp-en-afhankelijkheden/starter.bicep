// Oefening 2: Web App + App Service Plan
// Doel scope: resource group

param location string = resourceGroup().location
param environment string = 'dev'

// TODO 1: variable 'webAppName' -> bv. toLower('app-${environment}-${uniqueString(resourceGroup().id)}')

// TODO 2: resource App Service Plan
// resource appServicePlan 'Microsoft.Web/serverfarms@2023-12-01' = {
//   name: 'plan-${environment}'
//   location: location
//   sku: { name: 'F1', tier: 'Free' }
//   properties: { reserved: true } // reserved: true = Linux
// }

// TODO 3: resource Web App die verwijst naar appServicePlan.id
// resource webApp 'Microsoft.Web/sites@2023-12-01' = {
//   name: webAppName
//   location: location
//   properties: {
//     serverFarmId: appServicePlan.id
//     siteConfig: {
//       linuxFxVersion: 'NODE|20-lts'
//     }
//   }
// }

// TODO 4: output 'webAppUrl' string
