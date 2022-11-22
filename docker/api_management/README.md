# Docker Sample Deployments - SoftwareAG webMethods Developer Portal

Sample deployments of SoftwareAG webMethods API Management using Docker / Docker-compose.

Requirement: 

1) Run all commands from this directory (due to volumes path mapping)
2) Make sure you save a valid licenses in "licensing" directory:
 - ApiGateway Advanced
   - expected filename: "./licensing/apigateway-licenseKey.xml"
 - Developer Portal (only needed for the deployments involving Developer Portal product)
   - expected filename: "./licensing/devportal-licenseKey.xml"
 - Microgateway (only needed for the deployments involving Microgateway product)
   - expected filename: "./licensing/microgateway-licenseKey.xml"

## webMethods Versions

The webMethods major versions flavors (wM 10.11, etc...) are pre-defined in the files named "docker.env<version>"
To chose what version to load, you simply need to load the right environment file with your docker-compose command.

To help with that, you can set the following Environment variable, which will then be used in the docker-compose commands on this page:

```bash
export SAG_RELEASE=1015
```

## Deployment 1: API Gateway 2-nodes Cluster connected to external ElasticSearch/Kibana 

Start stack:

```
docker-compose --env-file ./docker.env${SAG_RELEASE} -f apigw-cluster-ignite-ext-es-kib/docker-compose-${SAG_RELEASE}.yml up -d
```

Cleanup:

```
docker-compose --env-file ./docker.env${SAG_RELEASE} -f apigw-cluster-ignite-ext-es-kib/docker-compose-${SAG_RELEASE}.yml down -v
```

## Deployment 2: Developer Portal 2-nodes Cluster connected to external ElasticSearch

Start stack:

```
docker-compose --env-file ./docker.env${SAG_RELEASE} -f devportal-cluster-ext-es/docker-compose.yml up -d
```

Cleanup:

```
docker-compose --env-file ./docker.env${SAG_RELEASE} -f devportal-cluster-ext-es/docker-compose.yml down -v
```

## Deployment 3: Complete API MGT Cluster (api gateway + devportal) connected to shared external ElasticSearch/Kibana 

This deployment includes a front load balancer (NGINX) to allow single point of access to the clustered APIGateway and Devportal components.

URLs through NGINX load balancer:
 - API Gateway UI: http://localhost/apigatewayui/
 - API Gateway Engine Runtime: http://localhost/
 - Developer Portal UI: http://localhost:81

URLs to the components directly (bypassing NGINX load balancer):
 - API Gateway UIs: 
    - http://localhost:9072/apigatewayui/
    - http://localhost:10072/apigatewayui/
 - API Gateway Engine Runtime: 
    - http://localhost:5555/
    - http://localhost:6555/
 - Developer Portal UI: 
    - http://localhost:8083/portal/
    - http://localhost:18083/portal/

Start stack:

```
docker-compose --env-file ./docker.env${SAG_RELEASE} -f apimgt-cluster-complete/docker-compose-${SAG_RELEASE}.yml up -d
```

Cleanup:

```
docker-compose --env-file ./docker.env${SAG_RELEASE} -f apimgt-cluster-complete/docker-compose-${SAG_RELEASE}.yml down -v
```
