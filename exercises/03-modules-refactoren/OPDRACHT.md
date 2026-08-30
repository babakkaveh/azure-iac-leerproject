# Oefening 3 — Refactoren naar modules

## Doel

Dezelfde resources als oefening 1 + 2, maar nu netjes opgesplitst in herbruikbare modules. Dit is hoe je Bicep in een echt team/project zou structureren.

## Opdracht

1. Maak `modules/storageAccount.bicep` — een module met inputs `location`, `environment`, `storageSku` en outputs `storageAccountName`, `blobEndpoint`
2. Maak `modules/appService.bicep` — een module met inputs `location`, `environment` (en evt. `sku`) en output `webAppUrl`
3. Vul `starter.bicep` aan zodat het beide modules aanroept

## Test het

```powershell
az deployment group what-if --resource-group rg-leerproject-dev --template-file starter.bicep
az deployment group create --resource-group rg-leerproject-dev --template-file starter.bicep
```

## Denkvraag

Wat is het voordeel van modules ten opzichte van alles in één bestand? En wat zou je nog verder verbeteren als dit door meerdere teams gebruikt zou worden (denk aan: versiebeheer van modules, een module-registry)?

Kijk naar https://aka.ms/avm (Azure Verified Modules) — dit zijn kant-en-klare, door Microsoft onderhouden modules die dit patroon op enterprise-schaal toepassen.
