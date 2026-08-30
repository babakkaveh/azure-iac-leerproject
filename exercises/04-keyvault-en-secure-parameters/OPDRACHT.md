# Oefening 4 — Key Vault en secure parameters

## Doel

Leren hoe je gevoelige waarden (wachtwoorden, connection strings) in Bicep verwerkt zonder dat ze ooit in plain text in je code, git-historie, of deployment-logs terechtkomen.

## Opdracht

Vul `starter.bicep` aan zodat:

1. Er een Key Vault (`Microsoft.KeyVault/vaults`) wordt aangemaakt, met RBAC-autorisatie aan (`enableRbacAuthorization: true`) in plaats van het oudere access-policy model
2. Er een parameter `adminPassword` is met de `@secure()` decorator
3. Die waarde als secret in de Key Vault wordt gezet (`Microsoft.KeyVault/vaults/secrets`)
4. Je bij het deployen de waarde NIET in een `.bicepparam`-bestand zet, maar meegeeft via de command line of een omgevingsvariabele (zie hieronder)

## Belangrijk: hoe geef je een secure parameter mee?

Zet 'm NOOIT in een bestand dat je commit. Gebruik in plaats daarvan:

```powershell
az deployment group create `
  --resource-group rg-leerproject-dev `
  --template-file starter.bicep `
  --parameters adminPassword=$(Read-Host -AsSecureString -Prompt "Wachtwoord" | ConvertFrom-SecureString -AsPlainText)
```

Of nog beter, in een CI/CD-pipeline: haal 'm op uit een GitHub Actions secret of een bestaande Key Vault, nooit hardcoded.

## Test het

```powershell
az deployment group what-if --resource-group rg-leerproject-dev --template-file starter.bicep
```

## Denkvraag

Waarom bestaat `@secure()` in Bicep, terwijl je dezelfde waarde ook gewoon als normale string-parameter had kunnen doorgeven? Kijk wat het verschil is in de deployment history (`az deployment group show`).
