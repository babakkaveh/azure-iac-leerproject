param location string = resourceGroup().location
param environment string = 'dev'

module storage 'modules/storageAccount.bicep' = {
  name: 'storageDeploy'
  params: {
    location: location
    environment: environment
  }
}

module webApp 'modules/appService.bicep' = {
  name: 'webAppDeploy'
  params: {
    location: location
    environment: environment
  }
}

output storageBlobEndpoint string = storage.outputs.blobEndpoint
output webAppUrl string = webApp.outputs.webAppUrl
