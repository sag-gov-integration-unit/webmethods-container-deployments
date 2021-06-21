# Docker Sample Deployments - API Gateway

Sample deployments of webMethods API Gateway using Docker / Docker-compose:

Requirement: Make sure you save in this current directory a valid licenses
 - for "ApiGateway Advanced Edition", and name the file as "licenseKey.xml"
 - for "Terracotta" (used for APIGateway clustering), and name the file as "terracotta-license.key"

## Testing Apigateway Standalone

Start stack:

```
docker-compose -f apigateway-standalone/docker-compose.yml up -d
```

Cleanup:

```
docker-compose -f apigateway-standalone/docker-compose.yml down
```

## Apigateway Single Node with External ElasticSearch Stack (Elastic Search + Kibana)

Start stack:

```
docker-compose -f apigateway-external-elasticstack/docker-compose.yml up -d
```

Cleanup:

```
docker-compose -f apigateway-external-elasticstack/docker-compose.yml down
```

## Testing Apigateway Multi-Node Clustered with External ElasticSearch and External Kibana

Start stack:

```
docker-compose -f apigateway-external-es-kib-clustered/docker-compose.yml up -d
```

Cleanup:

```
docker-compose -f apigateway-external-es-kib-clustered/docker-compose.yml down
```
