#!/bin/bash

NAMESPACE="$1"

#check for params
if [ "x$NAMESPACE" == "x" ]; then
    echo "Env var NAMESPACE is empty. Provide a valid target NAMESPACE"
    exit 2;
fi

## from GA helm charts
helm upgrade -i --namespace $NAMESPACE -f sampleapis-bookstore.yaml sampleapis-mgw-bookstore saggov-helm-charts/samplejavaapis-sidecar-microgateway
helm upgrade -i --namespace $NAMESPACE -f sampleapis-uszip.yaml sampleapis-mgw-uszip saggov-helm-charts/samplejavaapis-sidecar-microgateway

## from local helm charts (ie. for development)
# helm upgrade -i --namespace $NAMESPACE -f sampleapis-mgw-bookstore.yaml sampleapis-mgw-bookstore ${SAGGOV_HELMCHART_HOME}/samplejavaapis-sidecar-microgateway
# helm upgrade -i --namespace $NAMESPACE -f sampleapis-mgw-uszip.yaml sampleapis-mgw-uszip ${SAGGOV_HELMCHART_HOME}/samplejavaapis-sidecar-microgateway