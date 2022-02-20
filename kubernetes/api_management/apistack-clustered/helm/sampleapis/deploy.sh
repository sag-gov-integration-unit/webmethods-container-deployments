#!/bin/bash

NAMESPACE="$1"

#check for params
if [ "x$NAMESPACE" == "x" ]; then
    echo "Env var NAMESPACE is empty. Provide a valid target NAMESPACE"
    exit 2;
fi

helm install --namespace $NAMESPACE -f sampleapis-bookstore.yaml sampleapis-bookstore saggov-helm-charts/sample-java-apis
helm install --namespace $NAMESPACE -f sampleapis-uszip.yaml sampleapis-uszip saggov-helm-charts/sample-java-apis