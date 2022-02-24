# webmethods Microgateway and Microservice APIs

This page will walk through the deployment of APIS with embedded sidecar SoftwareAG Microgateway.
This should be a continuation of the APIGateway/Developer Portal steps already performed in [parent page](../README.md)

## Prep steps

### Set default namespace for the demo

```bash
export DEMO_NAMESPACE=apimgt-cluster-demo
kubectl config set-context --current --namespace=$DEMO_NAMESPACE
```

### Add license secrets for the container images

Microgateway product requires a valid license to operate. 
We'll add the valid licenses in K8s secrets so they can be used by the deployments.

Download and copy the licenses into the following ./licensing directory:
 - Microgateway
   - expected filename: "./licensing/microgateway-license.xml"

NOTE: Make sure to use the expected file name for the next "create secret" command to work.

```bash
kubectl create secret generic softwareag-apimgt-microgateway-licenses \
  --from-file=microgateway-license=./licensing/microgateway-license.xml
```

## Add microgateway archives to config maps

```bash
kubectl create configmap mgw-bookstore-archives \
  --from-file=../archives/apigw1011-archive-bookstore.zip \
  --from-file=../archives/apigw1011-transaction_logging.zip
```

```bash
kubectl create configmap mgw-uszip-archives \
  --from-file=../archives/apigw1011-archive-uszip.zip \
  --from-file=../archives/apigw1011-transaction_logging.zip
```

## Deploy/Detroy stack
### Deploy stack

```bash
/bin/sh deploy.sh $DEMO_NAMESPACE
```

### Delete stack

```bash
/bin/sh destroy.sh $DEMO_NAMESPACE
```

## Verify Bookstore

From the microgateway Container, executing the following query through the microgateway gives the right results:

```bash
curl http://localhost:9090/gateway/bookstore/books
```
==> returns expected JSON content

From any container in the namespace, through the application/microgateway service:

```bash
curl http://sampleapis-mgw-bookstore-sample-java-apis:9090/gateway/bookstore/books
```
==> returns expected JSON content

From any container in the namespace, through the application service, trying to reach the microservice WITHOUT going through the microgateway:

```bash
curl http://sampleapis-mgw-bookstore-sample-java-apis:7071/gateway/bookstore/books
```
==> returns ERROR (unreachable)