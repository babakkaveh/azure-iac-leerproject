# Oefening 2 — Web App bovenop een App Service Plan

## Doel

Leren hoe resources in Bicep van elkaar afhankelijk zijn, en hoe je de ene resource-eigenschap in de andere gebruikt (impliciete dependencies via `.id` — je hoeft `dependsOn` bijna nooit zelf te schrijven).

## Voorbereiding

```powershell
az group create --name rg-leerproject-dev --location westeurope
```
(sla over als je die al hebt van oefening 1)

## Opdracht

Vul `starter.bicep` aan zodat:

1. Er een `Microsoft.Web/serverfarms` (App Service Plan) resource is, SKU `F1` (gratis tier) of `B1`, Linux
2. Er een `Microsoft.Web/sites` (Web App) resource is die naar dat App Service Plan verwijst via `serverFarmId: appServicePlan.id`
3. De web app een `linuxFxVersion` heeft, bijvoorbeeld `'NODE|20-lts'`
4. De web app-naam globaal uniek is (web app-namen zijn wereldwijd uniek binnen `*.azurewebsites.net`) — gebruik weer `uniqueString()`
5. Je een output toevoegt met de volledige URL van de web app (`https://<name>.azurewebsites.net`)

## Test het

```powershell
az deployment group what-if --resource-group rg-leerproject-dev --template-file starter.bicep
az deployment group create --resource-group rg-leerproject-dev --template-file starter.bicep
```

Open daarna de output-URL in je browser — je zou de standaard Azure "welcome" pagina moeten zien.

## Denkvraag

Waarom heb je hier geen `dependsOn` nodig tussen de web app en het App Service Plan, terwijl Bicep ze wél in de juiste volgorde deployt? Kijk in de gegenereerde ARM JSON (`az bicep build --file starter.bicep`) om het antwoord te vinden.
