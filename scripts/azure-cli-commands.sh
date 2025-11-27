# Azure CLI quick commands (example)
# Login (Cloud Shell already authenticated)
az account show
# Create resource group
az group create --name rg-todo-final --location eastus
# Deploy ARM template
az deployment group create --resource-group rg-todo-final --template-file ./arm-templates/azure-deploy.json --parameters ./arm-templates/parameters.json
# Show web app URL
az webapp show --resource-group rg-todo-final --name todo-sample-app-12345 --query defaultHostName -o tsv
