#!/bin/bash

# This file can be used as an example and will pull the containers for a standlone webMethods API Platform
#   from the Software AG Government Solutions container registry.
#

#import variables for your Azure resources
source ../configs/docker.env$SAG_RELEASE

docker pull ${REG}webmethods-sample-apis-bookstore:$TAG_SAMPLE_APIS
docker pull ${REG}webmethods-sample-apis-uszip:$TAG_SAMPLE_APIS
docker pull ${REG}apigateway:$TAG_APIGATEWAY
docker pull ${REG}webmethods-apigateway-configurator:$TAG_APIGATEWAY_CONFIGURATOR
docker pull ${REG}webmethods-apiportal:$TAG_APIPORTAL
