#!/bin/bash

NAMESPACE="$1"

#check for params
if [ "x$NAMESPACE" == "x" ]; then
    echo "Env var NAMESPACE is empty. Provide a valid target NAMESPACE"
    exit 2;
fi

## update the helm repos first
helm repo update

## deploy apigateway/devportal configurators with the helm charts
helm upgrade -i --namespace $NAMESPACE -f ./descriptors/helm/apigateway-configurator.yaml webmethods-apigateway-configurator saggov-helm-charts/webmethods-apigateway-configurator
helm upgrade -i --namespace $NAMESPACE -f ./descriptors/helm/devportal-configurator.yaml webmethods-devportal-configurator saggov-helm-charts/webmethods-devportalconfigurator
