#!/bin/bash

NAMESPACE="$1"

#check for params
if [ "x$NAMESPACE" == "x" ]; then
    echo "Env var NAMESPACE is empty. Provide a valid target NAMESPACE"
    exit 2;
fi

## destroy apigateway/devportal
helm uninstall --namespace $NAMESPACE apigateway
helm uninstall --namespace $NAMESPACE webmethods-devportal

## destroy elastic / kibana
helm uninstall --namespace $NAMESPACE elasticsearch
helm uninstall --namespace $NAMESPACE kibana
