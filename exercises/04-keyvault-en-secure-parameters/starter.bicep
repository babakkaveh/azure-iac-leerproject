// Oefening 4: Key Vault + secure parameters
// Doel scope: resource group

param location string = resourceGroup().location
param environment string = 'dev'

@description('Wordt NOOIT gelogd of in plain text opgeslagen door Bicep/ARM')
@secure()
param adminPassword string

// TODO 1: variable 'keyVaultName' -> bv. toLower('kv-${environment}-${uniqueString(resourceGroup().id)}')
//         (Key Vault namen: max 24 tekens, alleen letters/cijfers/koppelteken)

// TODO 2: resource Key Vault met enableRbacAuthorization: true
// resource keyVault 'Microsoft.KeyVault/vaults@2023-07-01' = {
//   name: keyVaultName
//   location: location
//   properties: {
//     sku: { family: 'A', name: 'standard' }
//     tenantId: subscription().tenantId
//     enableRbacAuthorization: true
//   }
// }

// TODO 3: resource secret binnen de Key Vault
// resource adminSecret 'Microsoft.KeyVault/vaults/secrets@2023-07-01' = {
//   parent: keyVault
//   name: 'admin-password'
//   properties: {
//     value: adminPassword
//   }
// }

// TODO 4: output de Key Vault naam (NOOIT het secret zelf outputten!)
