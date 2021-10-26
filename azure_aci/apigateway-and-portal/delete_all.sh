#!/bin/bash

# This file will delete all of the containers in the standlone webMethods API Platform configuration.
#

#import variables for your Azure resources
source ../configs/docker.env$SAG_RELEASE

#perform the stop actions
echo Deleting Sample Bookstore API...
az container delete -y -n webmethods-apis-bookstore -g $RESOURCEGROUP

echo Deleting Sample US Zip API...
az container delete -y -n webmethods-apis-uszip -g $RESOURCEGROUP

echo Deleting API Gateway...
az container delete -y -n webmethods-apigateway -g $RESOURCEGROUP

echo Deleting API Configurator...
az container delete -y -n webmethods-gw-config -g $RESOURCEGROUP

echo Deleting API Portal...
az container delete -y -n webmethods-apiportal -g $RESOURCEGROUP