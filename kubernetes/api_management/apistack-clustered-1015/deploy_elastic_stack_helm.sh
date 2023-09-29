#!/bin/bash

NAMESPACE="$1"

#check for params
if [ "x$NAMESPACE" == "x" ]; then
    echo "Env var NAMESPACE is empty. Provide a valid target NAMESPACE"
    exit 2;
fi

## update the helm repos first
helm repo add elastic https://helm.elastic.co
helm repo update

## deploy elastic/kibana with helm
helm upgrade -i --namespace $NAMESPACE -f ./descriptors/helm/elasticseach.yaml --version 8.5.1 elasticsearch elastic/elasticsearch
helm upgrade -i --namespace $NAMESPACE -f ./descriptors/helm/kibana.yaml --version 8.5.1 kibana elastic/kibana