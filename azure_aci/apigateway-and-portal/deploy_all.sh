#!/bin/bash

# This file will deploy the containers for a standlone webMethods API Platform in ACI
# Please be sure to first build new images of the Gateway and the Portal with your own license files
#   see the Dockerfile.add-gw-license and Dockerfile.add-portal-license examples in this directory

#import variables for your Azure resources
source ../configs/docker.env$SAG_RELEASE

#execute provisioning
echo Deploying Containers from $REGISTRYLOGINSERVER

echo Deploying Sample Bookstore API...
az container create --no-wait --resource-group "$RESOURCEGROUP" --registry-login-server "$REGISTRYLOGINSERVER" \
--registry-password "$REGISTRYPASSWORD" --registry-username "$REGISTRYUSERNAME" \
--image "$REGISTRYLOGINSERVER/webmethods-sample-apis-bookstore:$TAG_SAMPLE_APIS" -n webmethods-apis-bookstore \
--dns-name-label apis-bookstore --cpu 1 --memory 1 --restart-policy Always --ports 7071

echo Deploying Sample US Zip API...
az container create --no-wait --resource-group "$RESOURCEGROUP" --registry-login-server "$REGISTRYLOGINSERVER" \
--registry-password "$REGISTRYPASSWORD" --registry-username "$REGISTRYUSERNAME" \
--image "$REGISTRYLOGINSERVER/webmethods-sample-apis-uszip:$TAG_SAMPLE_APIS" -n webmethods-apis-uszip \
--dns-name-label apis-uszip --cpu 1 --memory 1 --restart-policy Always --ports 7071

echo Deploying API Gateway...
az container create --no-wait --resource-group "$RESOURCEGROUP" --registry-login-server "$REGISTRYLOGINSERVER" \
--registry-password "$REGISTRYPASSWORD" --registry-username "$REGISTRYUSERNAME" \
--image "$REGISTRYLOGINSERVER/webmethods-apigateway-standalone:$TAG_APIGATEWAY" -n webmethods-apigateway \
--dns-name-label apigateway --cpu 2 --memory 4 --restart-policy Always --ports 9072 5555 5543 \
-e APIGW_ELASTICSEARCH_TENANTID=apigateway JAVA_MIN_MEM=512m JAVA_MAX_MEM=512m IDS_HEAP_SIZE=512m RUNTIME_WATT_PROPERTIES="watt.net.timeout=400 watt.server.threadPool=50 watt.server.threadPoolMin=25 watt.net.maxClientKeepaliveConns=10"

echo Deploying API Configurator...
az container create --no-wait --resource-group "$RESOURCEGROUP" --registry-login-server "$REGISTRYLOGINSERVER" \
--registry-password "$REGISTRYPASSWORD" --registry-username "$REGISTRYUSERNAME" \
--image "$REGISTRYLOGINSERVER/webmethods-apigateway-configurator:$TAG_APIGATEWAY_CONFIGURATOR" -n webmethods-gw-config \
--dns-name-label gw-config --cpu 1 --memory 1 --restart-policy Never --ports 7071 \
-e env_apigateway_configure_default_ignore_errors=true env_apigateway_configure_lb=true env_apigateway_configure_lb_ignore_errors=false env_apigateway_configure_extended_settings=true env_apigateway_configure_portalgateway=true env_apigateway_host=apigateway.usgovvirginia.azurecontainer.console.azure.us env_apigateway_port=5555 env_apigateway_rest_user=Administrator env_apigateway_rest_password=somethingnew env_apigateway_rest_password_old=manage env_apigateway_lb_http_url='http://apigateway.usgovvirginia.azurecontainer.console.azure.us:5555' env_apigateway_lb_https_url='https://apigateway.usgovvirginia.azurecontainer.console.azure.us:5543' env_apigateway_lb_websocket_url='ws://localhost' env_apigateway_lb_webapp_url='http://apigateway.usgovvirginia.azurecontainer.console.azure.us:9072' env_apigateway_portalgateway_gateway_url='http://apigateway.usgovvirginia.azurecontainer.console.azure.us:5555' env_apigateway_portalgateway_gateway_username=Administrator env_apigateway_portalgateway_gateway_password=somethingnew env_apigateway_portalgateway_portal_url='http://apiportal.usgovvirginia.azurecontainer.console.azure.us:18101' env_apigateway_portalgateway_portal_username=system env_apigateway_portalgateway_portal_password=manager

echo Deploying API Portal...
az container create --no-wait --resource-group "$RESOURCEGROUP" --registry-login-server "$REGISTRYLOGINSERVER" \
--registry-password "$REGISTRYPASSWORD" --registry-username "$REGISTRYUSERNAME" \
--image "$REGISTRYLOGINSERVER/webmethods-apiportal:$TAG_APIPORTAL" -n webmethods-apiportal \
--dns-name-label apiportal --cpu 2 --memory 8 --restart-policy Always --ports 18101 18102 \
-e LB_EXT_HOST=apiportal.usgovvirginia.azurecontainer.console.azure.us

echo Done.