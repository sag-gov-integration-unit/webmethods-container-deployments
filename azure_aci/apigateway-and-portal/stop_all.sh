#!/bin/bash

# This file will stop all of the containers in the standlone webMethods API Platform configuration.
#

#define variables for your Azure resources
source ../configs/docker.env$SAG_RELEASE

#perform the stop actions
echo Stopping Sample Bookstore API...
az container stop -n webmethods-apis-bookstore -g $RESOURCEGROUP

echo Stopping Sample US Zip API...
az container stop -n webmethods-apis-uszip -g $RESOURCEGROUP

echo Stopping API Gateway...
az container stop -n apigateway -g $RESOURCEGROUP

echo Stopping API Configurator...
az container stop -n webmethods-gw-config -g $RESOURCEGROUP

echo Stopping API Portal...
az container stop -n webmethods-apiportal -g $RESOURCEGROUP