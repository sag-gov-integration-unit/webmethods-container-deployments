#!/bin/bash

# This file will stop all of the gateway containers in the standlone webMethods API Platform configuration.
#

#define variables for your Azure resources
source ../configs/docker.env$SAG_RELEASE

echo Stopping API Gateway...
az container stop -n webmethods-apigateway -g $RESOURCEGROUP

echo Stopping API Configurator...
az container stop -n webmethods-gw-config -g $RESOURCEGROUP