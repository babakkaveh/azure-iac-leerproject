param location string = resourceGroup().location
param environment string = 'dev'

@description('Wordt NOOIT gelogd of in plain text opgeslagen door Bicep/ARM')
@secure()
param adminPassword string

var keyVaultName = toLower('kv-${environment}-${uniqueString(resourceGroup().id)}')

resource keyVault 'Microsoft.KeyVault/vaults@2023-07-01' = {
  name: keyVaultName
  location: location
  properties: {
    sku: {
      family: 'A'
      name: 'standard'
    }
    tenantId: subscription().tenantId
    enableRbacAuthorization: true
  }
  tags: {
    environment: environment
    project: 'azure-iac-leerproject'
  }
}

resource adminSecret 'Microsoft.KeyVault/vaults/secrets@2023-07-01' = {
  parent: keyVault
  name: 'admin-password'
  properties: {
    value: adminPassword
  }
}

output keyVaultName string = keyVault.name
