# Oefening 1 — Je eerste Bicep-bestand: een Storage Account

## Doel

Kennismaken met de basis van Bicep: parameters, variabelen, één resource, en een output. Dit bestand deployt binnen een **resource group** (die je zelf eerst even met de Azure CLI aanmaakt — dat is expres, zo zie je het verschil tussen "iets los aanmaken" en "iets in code beschrijven").

## Voorbereiding

```powershell
az group create --name rg-leerproject-dev --location westeurope
```

## Opdracht

Vul `starter.bicep` aan zodat:

1. Er een parameter `location` is (string, default = `resourceGroup().location`)
2. Er een parameter `environment` is die alleen `dev`, `test` of `prod` mag zijn (gebruik `@allowed()`)
3. Er een parameter `storageSku` is (default `Standard_LRS`)
4. Er een `variable` is die de storage account naam samenstelt: moet uniek, alleen kleine letters/cijfers, max 24 tekens zijn — gebruik `uniqueString(resourceGroup().id)`
5. Er een `Microsoft.Storage/storageAccounts` resource wordt aangemaakt met die naam, SKU, kind `StorageV2` en `TLS1_2` als minimum
6. Je een `output` toevoegt met de primary blob endpoint

## Test het

```powershell
az deployment group what-if --resource-group rg-leerproject-dev --template-file starter.bicep
az deployment group create --resource-group rg-leerproject-dev --template-file starter.bicep
```

## Hints

- Storage account namen mogen GEEN hoofdletters, koppeltekens of underscores bevatten
- `toLower(...)` en string-interpolatie (`'st${...}'`) helpen om de naam netjes op te bouwen
- Kijk pas naar `oplossing/main.bicep` als je vastloopt of klaar bent
