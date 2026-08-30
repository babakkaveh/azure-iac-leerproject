// Oefening 1: je eerste Bicep-bestand
// Doel scope: resource group (deploy met 'az deployment group create')

// TODO 1: parameter 'location' (string, default resourceGroup().location)

// TODO 2: parameter 'environment' met @allowed(['dev', 'test', 'prod'])

// TODO 3: parameter 'storageSku' (default 'Standard_LRS')

// TODO 4: variable 'storageAccountName' -> bv. toLower('st${environment}${uniqueString(resourceGroup().id)}')
//         (moet <= 24 tekens zijn, alleen kleine letters/cijfers)

// TODO 5: resource 'Microsoft.Storage/storageAccounts@2023-05-01'
// resource storageAccount 'Microsoft.Storage/storageAccounts@2023-05-01' = {
//   name: storageAccountName
//   location: location
//   sku: { name: storageSku }
//   kind: 'StorageV2'
//   properties: {
//     minimumTlsVersion: 'TLS1_2'
//     allowBlobPublicAccess: false
//   }
// }

// TODO 6: output 'storageBlobEndpoint' string
