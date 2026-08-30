using 'main.bicep'

param environment = 'dev'
param storageSku = 'Standard_LRS'
param appServiceSku = 'F1'

// adminPassword bewust NIET hier: geef 'm mee via --parameters adminPassword=... op de command line,
// of via een GitHub Actions secret in de pipeline. Nooit in een bestand dat je commit.
