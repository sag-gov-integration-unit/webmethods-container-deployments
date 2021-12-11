#!/bin/bash

# This file will deploy the container for a standlone webMethods Universal Messaging Server in ACI
# Please be sure to first build new images with your own license file
#   see the Dockerfile.add-license example in this directory

#import variables for your Azure resources
source ../configs/docker.env$SAG_RELEASE

#execute provisioning
echo Deploying Containers from $REGISTRYLOGINSERVER

echo Deploying Universal Messaging Server...
az container create --no-wait --resource-group "$RESOURCEGROUP" --registry-login-server "$REGISTRYLOGINSERVER" \
--registry-password "$REGISTRYPASSWORD" --registry-username "$REGISTRYUSERNAME" \
--image "${REGISTRYSERVERNAME}um-with-license:$TAG_UM" -n universalmessaging \
--dns-name-label ${DNS_PREFIX}universalmessaging --cpu 1 --memory 2 --restart-policy Always --ports 9000

echo Done.