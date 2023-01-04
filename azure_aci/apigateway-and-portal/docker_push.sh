#!/bin/bash

# This file can be used as an example and will push the containers for a standlone webMethods API Platform
#   to the ACR
#

#import variables for your Azure resources
source ../configs/docker.env$SAG_RELEASE

docker push ${REGISTRYSERVERNAME}webmethods-sample-apis-bookstore:dev-0.0.4
docker push ${REGISTRYSERVERNAME}webmethods-sample-apis-uszip:dev-0.0.4
docker push ${REGISTRYSERVERNAME}apigateway:dev-10.7-latest
docker push ${REGISTRYSERVERNAME}webmethods-apigateway-configurator:configurator-10.7-latest
docker push ${REGISTRYSERVERNAME}webmethods-apiportal:dev-10.7.1-36