#!/bin/bash

# This file will delete all of the gateway containers in the standlone webMethods API Platform configuration.
#

#import variables for your Azure resources
source ../configs/docker.env$SAG_RELEASE

#perform the stop actions
echo Deleting API Gateway...
az container delete -y -n apigateway -g $RESOURCEGROUP

echo Deleting API Configurator...
az container delete -y -n webmethods-gw-config -g $RESOURCEGROUP