# Docker Sample Deployments - SoftwareAG webMethods API Gateway

Sample deployments of webMethods API Gateway using Docker / Docker-compose:

Requirement: 

1) Run all commands from this directory (due to volumes path mapping)
2) Make sure you save in this current directory a valid licenses
 - for "ApiGateway Advanced Edition", and name the file as "licenseKey.xml"
 - for "Terracotta" (used for APIGateway clustering), and name the file as "terracotta-license.key"

## Apigateway Single Standalone Node
### Without any Reverse Proxy

Start stack:

```
docker-compose --env-file ../configs/.env.107 -f apigateway-standalone/docker-compose.yml up -d
```

Cleanup:

```
docker-compose --env-file ../configs/.env.107 -f apigateway-standalone/docker-compose.yml down
```

### with NGNX Reverse Proxy

Start stack:

```
docker-compose -f apigateway-standalone/docker-compose-nginx.yml up -d
```

Cleanup:

```
docker-compose -f apigateway-standalone/docker-compose-nginx.yml down
```

## Apigateway Single Node with External ElasticSearch Stack (Elastic Search + Kibana)
### Without any Reverse Proxy

Start stack:

```
docker-compose -f apigateway-external-elasticstack/docker-compose.yml up -d
```

Cleanup:

```
docker-compose -f apigateway-external-elasticstack/docker-compose.yml down
```
### With NGNX Reverse Proxy

Start stack:

```
docker-compose -f apigateway-external-elasticstack/docker-compose-nginx.yml up -d
```

Cleanup:

```
docker-compose -f apigateway-external-elasticstack/docker-compose-nginx.yml down
```
## Apigateway Two-Node Stateful Cluster with External ElasticSearch Stack and Terracotta

### Without any Reverse Proxy

Start stack:

```
docker-compose -f apigateway-clustered-external-elasticstack/docker-compose.yml up -d
```

Cleanup:

```
docker-compose -f apigateway-clustered-external-elasticstack/docker-compose.yml down
```

### With NGNX Reverse Proxy

Start stack:

```
docker-compose -f apigateway-clustered-external-elasticstack/docker-compose-nginx.yml up -d
```

Cleanup:

```
docker-compose -f apigateway-clustered-external-elasticstack/docker-compose-nginx.yml down
```