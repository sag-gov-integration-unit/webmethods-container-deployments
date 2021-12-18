#!/bin/bash

# This file will push the newly created SoftwareAG images to your own registry

REG_TARGET="$1"

#check for errors
if [ "x$SAG_RELEASE" == "x" ]; then
    echo "Env var SAG_RELEASE is empty. Provide a valid SAG_RELEASE value (107,1011). ie. 'export SAG_RELEASE=1011'"
    exit 2;
fi

if [ "x$REG_TARGET" == "x" ]; then
    echo "Usage: /bin/sh build.sh <REG_TARGET>"
    echo "REG_TARGET missing: please provide a valid parameter for the Target Registry where the SoftwareAG images will be uploaded to"
    exit 2;
fi

echo "Building new licensed images for SAG_RELEASE=${SAG_RELEASE}"

#import variables into the script
source ./configs/docker.env${SAG_RELEASE}

echo "Pushing newly created APIGateway images"
docker push ${REG_TARGET}/webmethods-apigateway-standalone:${TAG_APIGATEWAY}
docker push ${REG_TARGET}/webmethods-apigateway:${TAG_APIGATEWAY}
docker push ${REG_TARGET}/webmethods-microgateway:${TAG_APIGATEWAY}
docker push ${REG_TARGET}/webmethods-apigateway-configurator:${TAG_APIGATEWAY_CONFIGURATOR}

## API Portal
if [[ "$SAG_RELEASE" == "105" || "$SAG_RELEASE" == "107" ]]; then
    echo "Pushing newly created API Portal images"
    docker push ${REG_TARGET}/webmethods-apiportal:${TAG_APIPORTAL}
fi

## Developer Portal:
if [ "$SAG_RELEASE" == "1011" ]; then
    echo "Pushing newly created Developer Portal images"
    docker push ${REG_TARGET}/webmethods-devportal:${TAG_DEVPORTAL}
    docker push ${REG_TARGET}/webmethods-devportal-standalone:${TAG_DEVPORTAL}
    docker push ${REG_TARGET}/webmethods-devportal-configurator:${TAG_DEVPORTAL_CONFIGURATOR}
fi

echo "Pushing newly created Sample API images"
docker push ${REG_TARGET}/webmethods-sample-apis-bookstore:${TAG_SAMPLE_APIS}
docker push ${REG_TARGET}/webmethods-sample-apis-uszip:${TAG_SAMPLE_APIS}