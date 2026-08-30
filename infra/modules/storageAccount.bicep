@description('Locatie voor de storage account')
param location string = resourceGroup().location

@description('Omgeving: dev, test of prod')
param environment string = 'dev'

@description('SKU van de storage account')
param storageSku string = 'Standard_LRS'

var storageAccountName = toLower('st${environment}${uniqueString(resourceGroup().id)}')

resource storageAccount 'Microsoft.Storage/storageAccounts@2023-05-01' = {
  name: storageAccountName
  location: location
  sku: {
    name: storageSku
  }
  kind: 'StorageV2'
  properties: {
    minimumTlsVersion: 'TLS1_2'
    allowBlobPublicAccess: false
  }
  tags: {
    environment: environment
    project: 'azure-iac-leerproject'
  }
}

output storageAccountName string = storageAccount.name
output blobEndpoint string = storageAccount.properties.primaryEndpoints.blob
