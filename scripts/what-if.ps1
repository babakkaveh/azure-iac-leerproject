<#
.SYNOPSIS
  Laat zien wat er zou veranderen zonder daadwerkelijk te deployen.

.EXAMPLE
  ./scripts/what-if.ps1 -ResourceGroup rg-leerproject-dev
#>
param(
    [string]$ResourceGroup = "rg-leerproject-dev"
)

$adminPassword = Read-Host -AsSecureString -Prompt "Admin wachtwoord voor Key Vault-oefening"
$plainPassword = [Runtime.InteropServices.Marshal]::PtrToStringAuto(
    [Runtime.InteropServices.Marshal]::SecureStringToBSTR($adminPassword)
)

az deployment group what-if `
    --resource-group $ResourceGroup `
    --template-file "$PSScriptRoot/../infra/capstone/main.bicep" `
    --parameters "$PSScriptRoot/../infra/capstone/main.bicepparam" adminPassword=$plainPassword
