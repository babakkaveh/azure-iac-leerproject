// Oefening 3: refactor oefening 1 + 2 naar modules
// Doel scope: resource group

param location string = resourceGroup().location
param environment string = 'dev'

// TODO 1: roep modules/storageAccount.bicep aan
// module storage 'modules/storageAccount.bicep' = {
//   name: 'storageDeploy'
//   params: {
//     location: location
//     environment: environment
//   }
// }

// TODO 2: roep modules/appService.bicep aan
// module webApp 'modules/appService.bicep' = {
//   name: 'webAppDeploy'
//   params: {
//     location: location
//     environment: environment
//   }
// }

// TODO 3: geef beide outputs door
// output storageBlobEndpoint string = storage.outputs.blobEndpoint
// output webAppUrl string = webApp.outputs.webAppUrl
