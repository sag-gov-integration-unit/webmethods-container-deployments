#!/bin/bash

# This file can be used as an example and will pull the containers for a standlone webMethods API Platform
#   from the Software AG Government Solutions container registry.
#

#import variables for your Azure resources
#source ../configs/docker.env$SAG_RELEASE
REG=ghcr.io/softwareag-government-solutions/
TAG_APIGATEWAY=dev-10.7-latest
TAG_APIGATEWAY_CONFIGURATOR=configurator-10.7-latest
TAG_ELASTIC_VERSION=7.7.1
TAG_TERRACOTTA=dev-4.3.9-latest
TAG_SAMPLE_APIS=dev-0.0.4
TAG_APIPORTAL=dev-10.7.1-36
SAG_PASSWORD=somethingnew

#Set your Azure ACR Environment Specific Variables
RESOURCEGROUP="DarrynsResources"
REGISTRYLOGINSERVER="saggscloudimages.azurecr.us"
REGISTRYUSERNAME="saggscloudimages"
REGISTRYPASSWORD="fq3xMbfyNKOi8l1CFr/HRVvbsGTDFgfR"
VOLUMEACCOUNTKEY=HgnC8OXBDyqb94I/C2/de627a05cbTlyW2iW3FumyyUsCuFagkDsohdUN3YPVNre5M8tOiOAKNXhJ7i4tYZccw==
VOLUMEACCOUNTNAME=apistorage

echo $REG

docker pull $REG/webmethods-sample-apis-bookstore:$TAG_SAMPLE_APIS
docker pull $REG/webmethods-sample-apis-uszip:$TAG_SAMPLE_APIS
docker pull $REG/webmethods-apigateway-standalone:$TAG_APIGATEWAY
docker pull $REG/webmethods-apigateway-configurator:$TAG_APIGATEWAY_CONFIGURATOR
docker pull $REG/webmethods-apiportal:$TAG_APIPORTAL
