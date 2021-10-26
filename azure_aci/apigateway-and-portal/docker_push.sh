#!/bin/bash

# This file can be used as an example and will pull the containers for a standlone webMethods API Platform.
#

#import variables for your Azure resources
source ../configs/docker.env$SAG_RELEASE

docker push $REGISTRYLOGINSERVER/webmethods-sample-apis-bookstore:dev-0.0.4
docker push $REGISTRYLOGINSERVER/webmethods-sample-apis-uszip:dev-0.0.4
docker push $REGISTRYLOGINSERVER/webmethods-apigateway-standalone:dev-10.7-latest
docker push $REGISTRYLOGINSERVER/webmethods-apigateway-configurator:configurator-10.7-latest
docker push $REGISTRYLOGINSERVER/webmethods-apiportal:dev-10.7.1-36