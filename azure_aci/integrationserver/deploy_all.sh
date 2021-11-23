#!/bin/bash

# This file will deploy the container for a standlone webMethods Integration Server in ACI
# Please be sure to first build new images with your own license files
#   see the Dockerfile.add-license examples in this directory

#import variables for your Azure resources
source ../configs/docker.env$SAG_RELEASE

#execute provisioning
echo Deploying Containers from $REGISTRYLOGINSERVER

echo Deploying Integration Server...
az container create --no-wait --resource-group "$RESOURCEGROUP" --registry-login-server "$REGISTRYLOGINSERVER" \
--registry-password "$REGISTRYPASSWORD" --registry-username "$REGISTRYUSERNAME" \
--image "${REGISTRYSERVERNAME}webmethods4azure-with-license:$TAG_WM4AZURE" -n webmethods4azure \
--dns-name-label ${DNS_PREFIX}webmethods4azure --cpu 1 --memory 1 --restart-policy Always --ports 5555

echo Done.