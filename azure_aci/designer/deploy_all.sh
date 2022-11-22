#!/bin/bash

# This file will deploy the container for Designer Workstatoin in ACI

#import variables for your Azure resources
source ../configs/docker.env$SAG_RELEASE

#execute provisioning
echo Deploying Containers from $REGISTRYLOGINSERVER

echo Deploying Designer Workstation...
az container create --no-wait --resource-group "$RESOURCEGROUP" --registry-login-server "$REGISTRYLOGINSERVER" \
--registry-password "$REGISTRYPASSWORD" --registry-username "$REGISTRYUSERNAME" \
--image "${REGISTRYSERVERNAME}desktopdesigner:$TAG_DESIGNERWS" -n designer \
--dns-name-label ${DNS_PREFIX}designer --cpu 1 --memory 4 --restart-policy Always --ports 5902 5903

echo Done.