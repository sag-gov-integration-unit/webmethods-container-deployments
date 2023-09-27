#!/bin/bash

NAMESPACE="$1"

#check for params
if [ "x$NAMESPACE" == "x" ]; then
    echo "Env var NAMESPACE is empty. Provide a valid target NAMESPACE"
    exit 2;
fi

## deploy elastic with the elastic operator
kubectl --namespace $NAMESPACE apply -f ./descriptors/elastic_operator/elasticsearch.yaml
kubectl --namespace $NAMESPACE apply -f ./descriptors/elastic_operator/kibana.yaml