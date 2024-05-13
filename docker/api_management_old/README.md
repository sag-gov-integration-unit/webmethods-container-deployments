# Docker Sample Deployments - SoftwareAG webMethods API Gateway

Sample deployments of webMethods API Gateway using Docker / Docker-compose:

## Requirements

1) Run all commands from this directory (due to volumes path mapping)

2) Make sure you save a *valid licenses* with expected name (for proper volume mapping in docker) in the "./licensing" directory:

 - ApiGateway Advanced
   - expected filename: "./licensing/apigateway-licenseKey.xml"
 - API Portal (only needed for the deployments involving API Portal product)
   - expected filename: "./licensing/apiportal-licenseKey.xml"
 - Terracotta (only needed for the deployments involving API Gateway clustering)
   - expected filename: "./licensing/terracotta-license.key"
 - Microgateway (only needed for the deployments involving Microgateway product)
   - expected filename: "./licensing/microgateway-licenseKey.xml"

## webMethods Major Versions

The webMethods major versions flavors (wM 10.5, wM 10.7, etc...) are pre-defined in the ./configs folder, in files named "docker.env<version>"
To chose what version to load, you simply need to load the right environment file with your docker-compose command.

To help with that, you can set the following Environment variable, which will then be used in the docker-compose commands on this page:
If the variable is not defined, the commands will then automatically load the ./configs/docker.env file which is always set to the latest SAG RELEASE.

```bash
export SAG_RELEASE=107
```

or 

```bash
export SAG_RELEASE=105
```

## Optional: Overwriting Docker Configs

By default, all deployments in this project are setup to use the protected "Software AG Government Solutions GitHub Container Registry" at: 

ghcr.io/sag-gov-integration-unit/

If you need to overwrite certain docker deployment vars like TAG or REG, simply add them to your shell ENV variables...

ie. to use a different registry:

```bash
export REG=different.registry.com/library/ 
```

## Accessing the web interfaces

Upon stack started, and once the deployed containers are healthy, the following URLs should be accessible:

 - http://localhost:9072 (API Gateway UI)
 - http://localhost:18101 (API Portal UI)
 - http://localhost:5555 (API Gateway REST API Endpoint)
 - https://localhost:5543 (SSL-Secure API Gateway REST API Endpoint)

If using the NGINX reverse proxy configuration, the UIs are then accessible at the following "proxied" URLs:

 - http://localhost/apigatewayui (API Gateway UI)
 - http://localhost (API Gateway REST API Endpoint)


Default password: as defined in the value "SAG_PASSWORD" in the ./configs/docker.env<version> file

## Deployment Option 1: Full stack - APIGateway Standalone Node + APIPortal Standalone Node

### Start stack:

```
docker-compose --env-file ./configs/docker.env${SAG_RELEASE} -f apigateway-with-apiportal/docker-compose.yml up -d
```

### Cleanup:

```
docker-compose --env-file ./configs/docker.env${SAG_RELEASE} -f apigateway-with-apiportal/docker-compose.yml down -v
```

Note: Notice the "-v" option -- This is to remove the "apiportal-data" volume that was created for the portal data


## Deployment Option 2: Just Apigateway Single Standalone Node
### Without any Reverse Proxy

#### Start stack:

```
docker-compose --env-file ./configs/docker.env${SAG_RELEASE} -f apigateway-standalone/docker-compose.yml up -d
```

#### Cleanup:

```
docker-compose --env-file ./configs/docker.env${SAG_RELEASE} -f apigateway-standalone/docker-compose.yml down
```

### with NGNX Reverse Proxy

#### Start stack:

```
docker-compose --env-file ./configs/docker.env${SAG_RELEASE} -f apigateway-standalone/docker-compose-with-revproxy-nginx.yml up -d
```

#### Cleanup:

```
docker-compose --env-file ./configs/docker.env${SAG_RELEASE} -f apigateway-standalone/docker-compose-with-revproxy-nginx.yml down
```

## Deployment Option 3: Apigateway Single Node with External ElasticSearch Stack (Elastic Search + Kibana)
### Without any Reverse Proxy

Start stack:

```
docker-compose --env-file ./configs/docker.env${SAG_RELEASE} -f apigateway-external-elasticstack/docker-compose.yml up -d
```

Cleanup:

```
docker-compose --env-file ./configs/docker.env${SAG_RELEASE} -f apigateway-external-elasticstack/docker-compose.yml down
```
### With NGNX Reverse Proxy

Start stack:

```
docker-compose --env-file ./configs/docker.env${SAG_RELEASE} -f apigateway-external-elasticstack/docker-compose-nginx.yml up -d
```

Cleanup:

```
docker-compose --env-file ./configs/docker.env${SAG_RELEASE} -f apigateway-external-elasticstack/docker-compose-nginx.yml down
```
## Deployment Option 4: Apigateway Two-Node Stateful Cluster (with Terracotta) with External ElasticSearch Stack

### Without any Reverse Proxy

Start stack:

```
docker-compose --env-file ./configs/docker.env${SAG_RELEASE} -f apigateway-clustered-external-elasticstack/docker-compose.yml up -d
```

Cleanup:

```
docker-compose --env-file ./configs/docker.env${SAG_RELEASE} -f apigateway-clustered-external-elasticstack/docker-compose.yml down
```

### With NGNX Reverse Proxy

Start stack:

```
docker-compose --env-file ./configs/docker.env${SAG_RELEASE} -f apigateway-clustered-external-elasticstack/docker-compose-nginx.yml up -d
```

Cleanup:

```
docker-compose --env-file ./configs/docker.env${SAG_RELEASE} -f apigateway-clustered-external-elasticstack/docker-compose-nginx.yml down
```