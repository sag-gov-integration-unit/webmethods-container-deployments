#!/bin/bash

NAMESPACE="$1"

#check for params
if [ "x$NAMESPACE" == "x" ]; then
    echo "Env var NAMESPACE is empty. Provide a valid target NAMESPACE"
    exit 2;
fi

helm uninstall --namespace $NAMESPACE webmethods-apigateway
helm uninstall --namespace $NAMESPACE webmethods-devportal
kubectl --namespace $NAMESPACE delete -f elasticsearch.yaml
kubectl --namespace $NAMESPACE delete -f kibana.yaml
