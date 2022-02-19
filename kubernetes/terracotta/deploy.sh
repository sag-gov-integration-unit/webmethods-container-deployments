#!/bin/bash

NAMESPACE="$1"

#check for params
if [ "x$NAMESPACE" == "x" ]; then
    echo "Env var NAMESPACE is empty. Provide a valid target NAMESPACE"
    exit 2;
fi

helm install --namespace $NAMESPACE -f terracotta.yaml webmethods-terracotta saggov-helm-charts/webmethods-terracotta
