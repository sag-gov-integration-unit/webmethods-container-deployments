#!/bin/bash

NAMESPACE="$1"

#check for params
if [ "x$NAMESPACE" == "x" ]; then
    echo "Env var NAMESPACE is empty. Provide a valid target NAMESPACE"
    exit 2;
fi

## deploy elastic/kibana with helm
helm upgrade -i --namespace $NAMESPACE -f ./descriptors/helm/elasticseach.yaml --version 7.14.0 elasticsearch elastic/elasticsearch
helm upgrade -i --namespace $NAMESPACE -f ./descriptors/helm/kibana.yaml --version 7.14.0 kibana elastic/kibana

## deploy apigateway/devportal with the helm charts
helm upgrade -i --namespace $NAMESPACE -f ./descriptors/helm/devportal.yaml webmethods-devportal saggov-helm-charts/webmethods-devportal
helm upgrade -i --namespace $NAMESPACE -f ./descriptors/helm/apigateway.yaml webmethods-apigateway saggov-helm-charts/webmethods-apigateway

## from local helm charts (ie. for development)
# helm upgrade -i --namespace $NAMESPACE -f ./descriptors/helm/devportal.yaml webmethods-devportal ${SAGGOV_HELMCHART_HOME}/webmethods-devportal
# helm upgrade -i --namespace $NAMESPACE -f ./descriptors/helm/apigateway.yaml webmethods-apigateway ${SAGGOV_HELMCHART_HOME}/webmethods-apigateway

## deploy apigateway/devportal configurators with the helm charts
helm upgrade -i --namespace $NAMESPACE -f ./descriptors/helm/apigateway-configurator.yaml webmethods-apigateway-configurator saggov-helm-charts/webmethods-apigateway-configurator
helm upgrade -i --namespace $NAMESPACE -f ./descriptors/helm/devportal-configurator.yaml webmethods-devportal-configurator saggov-helm-charts/webmethods-devportal-configurator
