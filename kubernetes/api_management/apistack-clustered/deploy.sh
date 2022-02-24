#!/bin/bash

NAMESPACE="$1"

#check for params
if [ "x$NAMESPACE" == "x" ]; then
    echo "Env var NAMESPACE is empty. Provide a valid target NAMESPACE"
    exit 2;
fi

kubectl --namespace $NAMESPACE apply -f elasticsearch.yaml
kubectl --namespace $NAMESPACE apply -f kibana.yaml

## from GA helm charts
# helm upgrade -i --namespace $NAMESPACE -f devportal.yaml webmethods-devportal saggov-helm-charts/webmethods-devportal
# helm upgrade -i --namespace $NAMESPACE -f apigateway.yaml webmethods-apigateway saggov-helm-charts/webmethods-apigateway

## from local helm charts (ie. for development)
helm upgrade -i --namespace $NAMESPACE -f devportal.yaml webmethods-devportal ${SAGGOV_HELMCHART_HOME}/webmethods-devportal
helm upgrade -i --namespace $NAMESPACE -f apigateway.yaml webmethods-apigateway ${SAGGOV_HELMCHART_HOME}/webmethods-apigateway