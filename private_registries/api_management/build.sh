#!/bin/bash

# This file will build the SoftwareAG images with your own license file

REG_SOURCE="$1"
REG_TARGET="$2"

#check for errors
if [ "x$SAG_RELEASE" == "x" ]; then
    echo "provide a valid parameter for the product release (10.7,10.11)"
    exit 2;
fi

if [ "x$REG_SOURCE" == "x" ]; then
    echo "Usage: /bin/sh build.sh <REG_SOURCE> <REG_TARGET>"
    echo "REG_SOURCE missing: please provide a valid parameter for the Source Registry where the SoftwareAG image will be downloaded from"
    exit 2;
fi

if [ "x$REG_TARGET" == "x" ]; then
    echo "Usage: /bin/sh build.sh <REG_SOURCE> <REG_TARGET>"
    echo "REG_TARGET missing: please provide a valid parameter for the Target Registry where the SoftwareAG images will be uploaded to"
    exit 2;
fi

echo "Building new licensed images for SAG_RELEASE=${SAG_RELEASE}"

#import variables into the script
source ./configs/docker.env${SAG_RELEASE}

## apigateway
echo "Building APIGateway images:"
docker build -f Dockerfile.apigateway -t ${REG_TARGET}/webmethods-apigateway-standalone:${TAG_APIGATEWAY} --build-arg BASE_IMAGE=${REG_SOURCE}/webmethods-apigateway-standalone:${TAG_APIGATEWAY} .
docker build -f Dockerfile.apigateway -t ${REG_TARGET}/webmethods-apigateway:${TAG_APIGATEWAY} --build-arg BASE_IMAGE=${REG_SOURCE}/webmethods-apigateway:${TAG_APIGATEWAY} .
docker build -f Dockerfile.apigateway -t ${REG_TARGET}/webmethods-apigateway-configurator:${TAG_APIGATEWAY_CONFIGURATOR} --build-arg BASE_IMAGE=${REG_SOURCE}/webmethods-apigateway-configurator:${TAG_APIGATEWAY_CONFIGURATOR} .

## Microgateway:
echo "Building Microgateway images"
docker build -f Dockerfile.microgateway -t ${REG_TARGET}/webmethods-microgateway:${TAG_APIGATEWAY} --build-arg BASE_IMAGE=${REG_SOURCE}/webmethods-microgateway:${TAG_APIGATEWAY} .

echo "Listing newly created APIGateway images"
docker image ls ${REG_TARGET}/webmethods-apigateway-standalone:${TAG_APIGATEWAY}
docker image ls ${REG_TARGET}/webmethods-apigateway:${TAG_APIGATEWAY}
docker image ls ${REG_TARGET}/webmethods-microgateway:${TAG_APIGATEWAY}
docker image ls ${REG_TARGET}/webmethods-apigateway-configurator:${TAG_APIGATEWAY_CONFIGURATOR}

## API Portal
if [[ "$SAG_RELEASE" == "105" || "$SAG_RELEASE" == "107" ]]; then
    echo "Building API Portal image"
    docker build -f Dockerfile.apiportal -t ${REG_TARGET}/webmethods-apiportal:${TAG_APIPORTAL} --build-arg BASE_IMAGE=${REG_SOURCE}/webmethods-apiportal:${TAG_APIPORTAL} .

    echo "Listing newly created API Portal images"
    docker image ls ${REG_TARGET}/webmethods-apiportal:${TAG_APIPORTAL}
fi

## Developer Portal:
if [ "$SAG_RELEASE" == "1011" ]; then
    echo "Building Developer Portal images"
    docker build -f Dockerfile.devportal -t ${REG_TARGET}/webmethods-devportal:${TAG_DEVPORTAL} --build-arg BASE_IMAGE=${REG_SOURCE}/webmethods-devportal:${TAG_DEVPORTAL} .
    docker build -f Dockerfile.devportal -t ${REG_TARGET}/webmethods-devportal-standalone:${TAG_DEVPORTAL} --build-arg BASE_IMAGE=${REG_SOURCE}/webmethods-devportal-standalone:${TAG_DEVPORTAL} .
    docker build -f Dockerfile.devportal -t ${REG_TARGET}/webmethods-devportal-configurator:${TAG_DEVPORTAL_CONFIGURATOR} --build-arg BASE_IMAGE=${REG_SOURCE}/webmethods-devportal-configurator:${TAG_DEVPORTAL_CONFIGURATOR} .

    echo "Listing newly created Developer Portal images"
    docker image ls ${REG_TARGET}/webmethods-devportal:${TAG_DEVPORTAL}
    docker image ls ${REG_TARGET}/webmethods-devportal-standalone:${TAG_DEVPORTAL}
    docker image ls ${REG_TARGET}/webmethods-devportal-configurator:${TAG_DEVPORTAL_CONFIGURATOR}
fi

echo "Building Sample API images"
docker build -f Dockerfile.common -t ${REG_TARGET}/webmethods-sample-apis-bookstore:${TAG_SAMPLE_APIS} --build-arg BASE_IMAGE=${REG_SOURCE}/webmethods-sample-apis-bookstore:${TAG_SAMPLE_APIS} .
docker build -f Dockerfile.common -t ${REG_TARGET}/webmethods-sample-apis-uszip:${TAG_SAMPLE_APIS} --build-arg BASE_IMAGE=${REG_SOURCE}/webmethods-sample-apis-uszip:${TAG_SAMPLE_APIS} .

echo "Listing newly created Sample API images"
docker image ls ${REG_TARGET}/webmethods-sample-apis-bookstore:${TAG_SAMPLE_APIS}
docker image ls ${REG_TARGET}/webmethods-sample-apis-uszip:${TAG_SAMPLE_APIS}