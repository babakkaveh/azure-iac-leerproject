# GitHub Actions naar Azure zonder wachtwoorden (OIDC / federated credentials)

Dit is de manier waarop CI/CD naar Azure in een enterprise-omgeving hoort te werken: GitHub Actions logt in bij Azure via een kortlevend token (OIDC), zonder dat er ooit een client secret of wachtwoord in GitHub hoeft te staan. Relevant om te kennen voor het havenbedrijf.

## Stap 1 — App registration aanmaken in Microsoft Entra ID

```powershell
az ad app create --display-name "gh-azure-iac-leerproject"
```
Noteer de `appId` (= je toekomstige `AZURE_CLIENT_ID`).

```powershell
az ad sp create --id <appId>
```

## Stap 2 — Rechten geven op je resource group

```powershell
az role assignment create `
  --assignee <appId> `
  --role Contributor `
  --scope /subscriptions/<subscription-id>/resourceGroups/rg-leerproject-dev
```

## Stap 3 — Federated credential toevoegen (dit is de OIDC-koppeling)

```powershell
az ad app federated-credential create --id <appId> --parameters '{
  "name": "github-main-branch",
  "issuer": "https://token.actions.githubusercontent.com",
  "subject": "repo:<jouw-github-gebruikersnaam>/azure-iac-leerproject:ref:refs/heads/main",
  "audiences": ["api://AzureADTokenExchange"]
}'
```

Wil je ook vanuit pull requests kunnen deployen/valideren? Voeg een tweede federated credential toe met:
```
"subject": "repo:<jouw-github-gebruikersnaam>/azure-iac-leerproject:pull_request"
```

## Stap 4 — GitHub secrets instellen

In je GitHub repo: Settings → Secrets and variables → Actions → New repository secret

| Secret naam | Waarde |
|---|---|
| `AZURE_CLIENT_ID` | de `appId` van stap 1 |
| `AZURE_TENANT_ID` | `az account show --query tenantId -o tsv` |
| `AZURE_SUBSCRIPTION_ID` | `az account show --query id -o tsv` |
| `DEMO_ADMIN_PASSWORD` | een test-wachtwoord voor de Key Vault-oefening (alleen voor dit leerproject — in een echte pipeline haal je dit uit een bestaande vault, niet uit een secret) |

Geen `AZURE_CLIENT_SECRET` nodig — dat is precies het punt van OIDC.

## Testen

Push een wijziging in `infra/` naar een branch, open een pull request → de `bicep-validate.yml` workflow draait automatisch. Merge naar `main` → `deploy-capstone.yml` deployt.
