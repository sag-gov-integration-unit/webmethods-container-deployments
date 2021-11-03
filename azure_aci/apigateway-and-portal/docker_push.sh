#!/bin/bash

# This file can be used as an example and will push the containers for a standlone webMethods API Platform
#   to the ACR
#

#import variables for your Azure resources
source ../configs/docker.env$SAG_RELEASE

docker push $REGISTRYSERVERNAMEwebmethods-sample-apis-bookstore:dev-0.0.4
docker push $REGISTRYSERVERNAMEwebmethods-sample-apis-uszip:dev-0.0.4
docker push $REGISTRYSERVERNAMEwebmethods-apigateway-standalone:dev-10.7-latest
docker push $REGISTRYSERVERNAMEwebmethods-apigateway-configurator:configurator-10.7-latest
docker push $REGISTRYSERVERNAMEwebmethods-apiportal:dev-10.7.1-36