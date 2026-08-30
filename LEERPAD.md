# Leerpad

Werk deze stappen op volgorde af. Elke stap bouwt voort op de vorige. Doe elke oefening eerst zelf voordat je naar de `oplossing/` map kijkt.

## Stap 0 — Git en GitHub oefenen (doe dit zelf, staat niet klaar)

Dit project wordt bewust NIET voor je in Git gezet — dat is je eerste oefening:

1. Maak een nieuwe (lege) repository aan op GitHub, bijvoorbeeld `azure-iac-leerproject`
2. Open een terminal in deze map en voer uit:
   ```powershell
   git init
   git add .
   git commit -m "Init: Azure IaC leerproject"
   git branch -M main
   git remote add origin https://github.com/<jouw-gebruikersnaam>/azure-iac-leerproject.git
   git push -u origin main
   ```
3. Maak vanaf nu voor elke oefening een eigen branch, bijvoorbeeld `oefening-1-storage`, en open een pull request naar `main` als je klaar bent. Zo oefen je meteen de GitHub-workflow die je in een werkomgeving ook gebruikt.

## Stap 1 — Eerste Bicep-bestand: Resource Group + Storage Account

Map: `exercises/01-resource-group-storage/`

Doel: een storage account deployen met parameters, variabelen en outputs.

```powershell
az deployment sub create --location westeurope --template-file exercises/01-resource-group-storage/starter.bicep
```

## Stap 2 — Afhankelijkheden: een Web App bovenop een App Service Plan

Map: `exercises/02-webapp-en-afhankelijkheden/`

Doel: leren hoe Bicep afhankelijkheden tussen resources afhandelt (impliciet via `.id`-references).

## Stap 3 — Refactoren naar modules

Map: `exercises/03-modules-refactoren/`

Doel: dezelfde resources als stap 1/2, maar opgesplitst in herbruikbare `modules/*.bicep`-bestanden die je vanuit `main.bicep` aanroept. Dit is hoe je het in een echt team zou opzetten.

## Stap 4 — Key Vault en secure parameters

Map: `exercises/04-keyvault-en-secure-parameters/`

Doel: een Key Vault deployen, een secret erin zetten via Bicep, en leren werken met `@secure()`-parameters zodat er nooit een wachtwoord in plain text in je code of git-historie staat.

## Stap 5 — What-if en validatie

Voordat je ooit iets deployt in een echte omgeving, wil je weten wát er gaat veranderen:

```powershell
az deployment group what-if --resource-group <jouw-rg> --template-file infra/capstone/main.bicep --parameters infra/capstone/main.bicepparam
```

Oefen dit bewust met een kleine wijziging (bv. een tag toevoegen) zodat je het verschil ziet tussen een "no-op" en een echte wijziging.

## Stap 6 — Eindopdracht (capstone): alles samen via GitHub Actions

Map: `infra/capstone/`

Dit combineert alles: resource group, storage, web app en key vault via modules, en een GitHub Actions pipeline (`.github/workflows/`) die:

1. Bij elke pull request: Bicep lint + `what-if` uitvoert en het resultaat als comment terugzet
2. Bij merge naar `main`: automatisch deployt naar Azure

Zie `.github/workflows/README-OIDC-SETUP.md` voor het instellen van passwordless authenticatie (federated credentials) tussen GitHub Actions en Azure — dit is de manier waarop dit in een enterprise-omgeving hoort te werken, dus ook relevant voor het havenbedrijf.

## Klaar? Volgende stappen

- Voeg een eigen resource toe die nog niet in dit project zit (bv. een Log Analytics workspace of Application Insights) en koppel die aan de web app
- Kijk naar Azure Verified Modules (AVM) — de officiële, door Microsoft onderhouden Bicep-modules: https://aka.ms/avm
- Oefen met Bicep linting rules (`bicepconfig.json`) om je eigen stijlregels af te dwingen
