<#
.SYNOPSIS
  Deployt de capstone Bicep-template handmatig naar een resource group.

.EXAMPLE
  ./scripts/deploy.ps1 -ResourceGroup rg-leerproject-dev
#>
param(
    [string]$ResourceGroup = "rg-leerproject-dev",
    [string]$Location = "westeurope"
)

Write-Host "Resource group '$ResourceGroup' aanmaken als die nog niet bestaat..."
az group create --name $ResourceGroup --location $Location | Out-Null

$adminPassword = Read-Host -AsSecureString -Prompt "Admin wachtwoord voor Key Vault-oefening"
$plainPassword = [Runtime.InteropServices.Marshal]::PtrToStringAuto(
    [Runtime.InteropServices.Marshal]::SecureStringToBSTR($adminPassword)
)

Write-Host "Deployen..."
az deployment group create `
    --resource-group $ResourceGroup `
    --template-file "$PSScriptRoot/../infra/capstone/main.bicep" `
    --parameters "$PSScriptRoot/../infra/capstone/main.bicepparam" adminPassword=$plainPassword
