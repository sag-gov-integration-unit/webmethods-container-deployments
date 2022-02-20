#!/bin/bash

NAMESPACE="$1"

#check for params
if [ "x$NAMESPACE" == "x" ]; then
    echo "Env var NAMESPACE is empty. Provide a valid target NAMESPACE"
    exit 2;
fi

helm uninstall --namespace $NAMESPACE sampleapis-bookstore
helm uninstall --namespace $NAMESPACE sampleapis-uszip