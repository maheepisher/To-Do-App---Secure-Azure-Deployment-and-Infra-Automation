# Cloud Shell helper: build and push image to ACR (replace placeholders)
ACR_NAME=<yourACRname>
RESOURCE_GROUP=rg-todo-final
az acr create --name $ACR_NAME --resource-group $RESOURCE_GROUP --sku Basic --admin-enabled true
az acr login --name $ACR_NAME
docker build -t $ACR_NAME.azurecr.io/todo-sample:latest ./app
docker push $ACR_NAME.azurecr.io/todo-sample:latest
# Then update App Service to use the new image from ACR (example):
# az webapp config container set --name todo-sample-app-12345 --resource-group rg-todo-final --docker-custom-image-name $ACR_NAME.azurecr.io/todo-sample:latest --docker-registry-server-url https://$ACR_NAME.azurecr.io
