# Docker Sample Deployments - SoftwareAG webMethods API Gateway

Sample deployments of webMethods API Gateway using Docker / Docker-compose:

## Requirements

1) Run all commands from this directory (due to volumes path mapping)
   
2) Make sure you save in this current directory *valid licenses* with expected name (for proper volume mapping in docker)

 - "ApiGateway Advanced Edition"
   - expected filename: "apigateway-licenseKey.xml"
 - Terracotta (for clustering)
   - expected filename: "terracotta-license.key"
 - "API Portal"
   - expected filename: "apiportal-licenseKey.xml"
 - "Microgateway"
   - expected filename: "microgateway-licenseKey.xml"

## webMethods Major Versions

The webMethods major versions flavors (wM 10.5, wM 10.7, etc...) are pre-defined in the ./configs folder, in files named ".env<version>"
To chose what version to load, you simply need to load the right environment file with your docker-compose command.

To help with that, you can set the following Environment variable, which will then be used in the docker-compose commands on this page:
If the variable is not defined, the commands will then automatically load the ./configs/.env file which is always set to the latest SAG RELEASE.

```bash
export SAG_RELEASE=107
```

or 

```bash
export SAG_RELEASE=105
```

## Apigateway Single Standalone Node
### Without any Reverse Proxy

Start stack:

```
docker-compose --env-file ./configs/.env${SAG_RELEASE} -f apigateway-standalone/docker-compose.yml up -d
```

Cleanup:

```
docker-compose --env-file ./configs/.env${SAG_RELEASE} -f apigateway-standalone/docker-compose.yml down
```

### with NGNX Reverse Proxy

Start stack:

```
docker-compose --env-file ./configs/.env${SAG_RELEASE} -f apigateway-standalone/docker-compose-nginx.yml up -d
```

Cleanup:

```
docker-compose --env-file ./configs/.env${SAG_RELEASE} -f apigateway-standalone/docker-compose-nginx.yml down
```

## Apigateway Single Node with External ElasticSearch Stack (Elastic Search + Kibana)
### Without any Reverse Proxy

Start stack:

```
docker-compose --env-file ./configs/.env${SAG_RELEASE} -f apigateway-external-elasticstack/docker-compose.yml up -d
```

Cleanup:

```
docker-compose --env-file ./configs/.env${SAG_RELEASE} -f apigateway-external-elasticstack/docker-compose.yml down
```
### With NGNX Reverse Proxy

Start stack:

```
docker-compose --env-file ./configs/.env${SAG_RELEASE} -f apigateway-external-elasticstack/docker-compose-nginx.yml up -d
```

Cleanup:

```
docker-compose --env-file ./configs/.env${SAG_RELEASE} -f apigateway-external-elasticstack/docker-compose-nginx.yml down
```
## Apigateway Two-Node Stateful Cluster with External ElasticSearch Stack and Terracotta

### Without any Reverse Proxy

Start stack:

```
docker-compose --env-file ./configs/.env${SAG_RELEASE} -f apigateway-clustered-external-elasticstack/docker-compose.yml up -d
```

Cleanup:

```
docker-compose --env-file ./configs/.env${SAG_RELEASE} -f apigateway-clustered-external-elasticstack/docker-compose.yml down
```

### With NGNX Reverse Proxy

Start stack:

```
docker-compose --env-file ./configs/.env${SAG_RELEASE} -f apigateway-clustered-external-elasticstack/docker-compose-nginx.yml up -d
```

Cleanup:

```
docker-compose --env-file ./configs/.env${SAG_RELEASE} -f apigateway-clustered-external-elasticstack/docker-compose-nginx.yml down
```