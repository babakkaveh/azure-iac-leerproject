@description('Locatie voor de Key Vault')
param location string = resourceGroup().location

@description('Omgeving: dev, test of prod')
param environment string = 'dev'

@description('Wordt NOOIT gelogd of in plain text opgeslagen door Bicep/ARM')
@secure()
param adminPassword string

@description('Principal ID (managed identity) die "Key Vault Secrets User" krijgt op deze vault; laat leeg om over te slaan')
param readerPrincipalId string = ''

var keyVaultName = toLower('kv-${environment}-${uniqueString(resourceGroup().id)}')

// Ingebouwde rol "Key Vault Secrets User"
var secretsUserRoleId = '4633458b-17de-408a-b874-0445c86b69e6'

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

resource secretsReaderAssignment 'Microsoft.Authorization/roleAssignments@2022-04-01' = if (!empty(readerPrincipalId)) {
  name: guid(keyVault.id, readerPrincipalId, secretsUserRoleId)
  scope: keyVault
  properties: {
    roleDefinitionId: subscriptionResourceId('Microsoft.Authorization/roleDefinitions', secretsUserRoleId)
    principalId: readerPrincipalId
    principalType: 'ServicePrincipal'
  }
}

output keyVaultName string = keyVault.name
