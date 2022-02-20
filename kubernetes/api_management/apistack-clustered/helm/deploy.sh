#!/bin/bash

NAMESPACE="$1"

#check for params
if [ "x$NAMESPACE" == "x" ]; then
    echo "Env var NAMESPACE is empty. Provide a valid target NAMESPACE"
    exit 2;
fi

kubectl --namespace $NAMESPACE apply -f elasticsearch.yaml
kubectl --namespace $NAMESPACE apply -f kibana.yaml
helm upgrade -i --namespace $NAMESPACE -f devportal.yaml webmethods-devportal saggov-helm-charts/webmethods-devportal
helm upgrade -i --namespace $NAMESPACE -f apigateway.yaml webmethods-apigateway saggov-helm-charts/webmethods-apigateway