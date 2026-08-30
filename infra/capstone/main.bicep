// Eindopdracht: alles samen
// Resource group + storage + web app (met managed identity) + key vault
// De web app krijgt automatisch leestoegang tot de Key Vault via RBAC (geen wachtwoorden nodig)

@description('Locatie voor alle resources')
param location string = resourceGroup().location

@description('Omgeving: dev, test of prod')
@allowed([
  'dev'
  'test'
  'prod'
])
param environment string = 'dev'

@description('SKU van de storage account')
param storageSku string = 'Standard_LRS'

@description('SKU van het App Service Plan')
param appServiceSku string = 'F1'

@description('Wordt NOOIT gelogd of in plain text opgeslagen door Bicep/ARM. Geef mee via CLI, nooit via een gecommit bestand.')
@secure()
param adminPassword string

module storage '../modules/storageAccount.bicep' = {
  name: 'storageDeploy'
  params: {
    location: location
    environment: environment
    storageSku: storageSku
  }
}

module webApp '../modules/appService.bicep' = {
  name: 'webAppDeploy'
  params: {
    location: location
    environment: environment
    sku: appServiceSku
  }
}

module keyVault '../modules/keyVault.bicep' = {
  name: 'keyVaultDeploy'
  params: {
    location: location
    environment: environment
    adminPassword: adminPassword
    readerPrincipalId: webApp.outputs.webAppPrincipalId
  }
}

output storageBlobEndpoint string = storage.outputs.blobEndpoint
output webAppUrl string = webApp.outputs.webAppUrl
output keyVaultName string = keyVault.outputs.keyVaultName
