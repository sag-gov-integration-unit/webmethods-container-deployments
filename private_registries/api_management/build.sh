#!/bin/bash

# This file will build the SoftwareAG images with your own license file

REG_SOURCE="$1"
REG_TARGET="$2"

#check for errors
if [ "x$SAG_RELEASE" == "x" ]; then
    echo "Env var SAG_RELEASE is empty. Provide a valid SAG_RELEASE value (107,1011). ie. 'export SAG_RELEASE=1011'"
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
docker build -f Dockerfile.apigateway --no-cache -t ${REG_TARGET}/apigateway-minimal:${TAG_APIGATEWAY} --build-arg BASE_IMAGE=${REG_SOURCE}/apigateway-minimal:${TAG_APIGATEWAY} .
# docker build -f Dockerfile.apigateway --no-cache -t ${REG_TARGET}/webmethods-apigateway-configurator:${TAG_APIGATEWAY_CONFIGURATOR} --build-arg BASE_IMAGE=${REG_SOURCE}/webmethods-apigateway-configurator:${TAG_APIGATEWAY_CONFIGURATOR} .
# docker build -f Dockerfile.apigateway.deployer --no-cache -t ${REG_TARGET}/webmethods-apigateway-deployer-sampleapis:${TAG_APIGATEWAY_CONFIGURATOR} --build-arg BASE_IMAGE=${REG_SOURCE}/webmethods-apigateway-deployer:${TAG_APIGATEWAY_CONFIGURATOR} .

## Developer Portal:
echo "Building Developer Portal images"
docker build -f Dockerfile.devportal --no-cache -t ${REG_TARGET}/devportal:${TAG_DEVPORTAL} --build-arg BASE_IMAGE=${REG_SOURCE}/devportal:${TAG_DEVPORTAL} .
# docker build -f Dockerfile.devportal --no-cache -t ${REG_TARGET}/webmethods-devportal-configurator:${TAG_DEVPORTAL_CONFIGURATOR} --build-arg BASE_IMAGE=${REG_SOURCE}/webmethods-devportal-configurator:${TAG_DEVPORTAL_CONFIGURATOR} .

## Microgateway:
echo "Building Microgateway images"
docker build -f Dockerfile.microgateway --no-cache -t ${REG_TARGET}/microgateway:${TAG_APIGATEWAY} --build-arg BASE_IMAGE=${REG_SOURCE}/microgateway:${TAG_APIGATEWAY} .

## terracotta
docker build -f Dockerfile.terracotta --no-cache -t ${REG_TARGET}/bigmemorymax-server:${TAG_TERRACOTTA} --build-arg BASE_IMAGE=${REG_SOURCE}/bigmemorymax-server:${TAG_TERRACOTTA} .
docker build -f Dockerfile.terracotta --no-cache -t ${REG_TARGET}/bigmemorymax-management-server:${TAG_TERRACOTTA} --build-arg BASE_IMAGE=${REG_SOURCE}/bigmemorymax-management-server:${TAG_TERRACOTTA} .

echo "Listing newly created images"
docker image ls ${REG_TARGET}/apigateway-minimal:${TAG_APIGATEWAY}
docker image ls ${REG_TARGET}/microgateway:${TAG_APIGATEWAY}
docker image ls ${REG_TARGET}/bigmemorymax-server:${TAG_APIGATEWAY_CONFIGURATOR}
docker image ls ${REG_TARGET}/bigmemorymax-management-server:${TAG_APIGATEWAY_CONFIGURATOR}
docker image ls ${REG_TARGET}/devportal:${TAG_DEVPORTAL}

echo "Building Sample API images"
docker build -f Dockerfile.common --no-cache -t ${REG_TARGET}/webmethods-sample-apis-bookstore:${TAG_SAMPLE_APIS} --build-arg BASE_IMAGE=${REG_SOURCE}/webmethods-sample-apis-bookstore:${TAG_SAMPLE_APIS} .
docker build -f Dockerfile.common --no-cache -t ${REG_TARGET}/webmethods-sample-apis-uszip:${TAG_SAMPLE_APIS} --build-arg BASE_IMAGE=${REG_SOURCE}/webmethods-sample-apis-uszip:${TAG_SAMPLE_APIS} .

echo "Listing newly created Sample API images"
docker image ls ${REG_TARGET}/webmethods-sample-apis-bookstore:${TAG_SAMPLE_APIS}
docker image ls ${REG_TARGET}/webmethods-sample-apis-uszip:${TAG_SAMPLE_APIS}