#!/bin/bash

NAMESPACE="$1"

#check for params
if [ "x$NAMESPACE" == "x" ]; then
    echo "Env var NAMESPACE is empty. Provide a valid target NAMESPACE"
    exit 2;
fi

## destroy apigateway/devportal configurators
helm uninstall --namespace $NAMESPACE webmethods-apigateway-configurator
helm uninstall --namespace $NAMESPACE webmethods-devportal-configurator