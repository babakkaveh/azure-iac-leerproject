# Azure IaC Leerproject (Bicep + VS Code + GitHub)

Leerproject om vier dingen tegelijk onder de knie te krijgen:

1. **Azure** — resources begrijpen en beheren (resource groups, storage, web apps, key vault)
2. **VS Code** — als IDE voor infrastructure-as-code, met de juiste extensies en workflow
3. **GitHub** — versiebeheer, branches, pull requests en GitHub Actions
4. **Infrastructure as Code (Bicep)** — Azure's eigen IaC-taal, van losse resources tot herbruikbare modules en een CI/CD-pipeline

Dit project is opgezet met Bicep als IaC-tool, omdat de vacature bij het havenbedrijf dit als vereiste noemt.

## Vereisten

Voordat je begint heb je nodig:

- Een **Azure-account** met een actieve subscription (een gratis/sandbox subscription is genoeg om te oefenen)
- Een **GitHub-account**
- **VS Code** geïnstalleerd
- **Azure CLI** geïnstalleerd (`az --version` om te checken, anders installeren via https://learn.microsoft.com/cli/azure/install-azure-cli)
- **Git** geïnstalleerd (`git --version` om te checken)

## VS Code extensies

Open dit project in VS Code — je krijgt automatisch een melding om de aanbevolen extensies te installeren (zie `.vscode/extensions.json`). Belangrijkste:

- **Bicep** (ms-azuretools.vscode-bicep) — syntax highlighting, validatie, IntelliSense
- **Azure Resources** (ms-azuretools.vscode-azureresourcegroups) — je Azure-resources bekijken vanuit VS Code
- **Azure Account** (ms-vscode.azure-account) — inloggen op Azure vanuit VS Code
- **GitHub Pull Requests** (github.vscode-pull-request-github) — PR's beheren zonder de browser

## Projectstructuur

```
infra/               Herbruikbare Bicep-modules en het "eindproject" (capstone)
exercises/           Stap-voor-stap oefeningen, elk met een opdracht en een oplossing
.github/workflows/   GitHub Actions pipelines (validatie + deployment)
scripts/             Handmatige deploy-scripts (PowerShell)
```

## Hoe te beginnen

Volg `LEERPAD.md` — dat is de stap-voor-stap route door dit project, van "eerste keer inloggen op Azure via de CLI" tot "een volledige CI/CD-pipeline die Bicep valideert en deployt via GitHub Actions".

## Azure-login testen

```powershell
az login
az account show
```

Als dit werkt, ben je klaar om te beginnen.
