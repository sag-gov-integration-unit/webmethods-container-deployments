#!/bin/bash

NAMESPACE="$1"

#check for params
if [ "x$NAMESPACE" == "x" ]; then
    echo "Env var NAMESPACE is empty. Provide a valid target NAMESPACE"
    exit 2;
fi

## deploy elastic with the elastic operator
kubectl --namespace $NAMESPACE apply -f ./descriptors/elastic_operator/elasticsearch.yaml
kubectl --namespace $NAMESPACE apply -f ./descriptors/elastic_operator/kibana.yaml

## update the helm repos first
helm repo update

## deploy apigateway/devportal with the helm charts from helm chart public repo
helm upgrade -i --namespace $NAMESPACE -f ./descriptors/helm/devportal.yaml webmethods-devportal saggov-helm-charts/webmethods-devportal
helm upgrade -i --namespace $NAMESPACE -f ./descriptors/helm/apigateway.yaml webmethods-apigateway saggov-helm-charts/webmethods-apigateway