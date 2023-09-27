#!/bin/bash

NAMESPACE="$1"

#check for params
if [ "x$NAMESPACE" == "x" ]; then
    echo "Env var NAMESPACE is empty. Provide a valid target NAMESPACE"
    exit 2;
fi

## destroy apigateway/devportal with the helm chart uninstall
helm uninstall --namespace $NAMESPACE apigateway
helm uninstall --namespace $NAMESPACE devportal