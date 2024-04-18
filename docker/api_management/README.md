# Docker Sample Deployments - SoftwareAG webMethods Developer Portal

Sample deployments of SoftwareAG webMethods API Management using Docker / Docker-compose.

Requirements: 

1) Get Access to the SoftwareAG Container registry [https://containers.softwareag.com/](https://containers.softwareag.com) and ability to pull down the SoftwareAG Container images
2) Run all commands from this directory (due to volumes path mapping)
3) Make sure you save a valid licenses in "licensing" directory:
 - ApiGateway Advanced
   - expected filename: "./licensing/apigateway-licenseKey.xml"
 - Developer Portal (only needed for the deployments involving Developer Portal product)
   - expected filename: "./licensing/devportal-licenseKey.xml"
 - Microgateway (Optional: only needed for the deployments involving this component)
   - expected filename: "./licensing/microgateway-licenseKey.xml"
 - Terracotta BigMemory (Optional: only needed for the deployments involving this component)
   - expected filename: "./licensing/terracotta-license.key"

## webMethods API Management Versions

The webMethods major versions flavors (wM 10.11, etc...) are pre-defined in the files named "docker.env<version>"
To chose what version to load, you simply need to load the right environment file with your docker-compose command.

To help with that, you can set the following Environment variable, which will then be used in the docker-compose commands on this page:

```bash
export SAG_RELEASE=1015
```

## Deployment 1a: API Gateway 2-nodes Cluster (with ignite) connected to external ElasticSearch/Kibana 

Start stack:

```
docker compose --env-file ./docker.env${SAG_RELEASE} -f apigw-cluster-ignite-ext-es-kib/docker-compose-${SAG_RELEASE}.yml up -d
```

Cleanup:

```
docker compose --env-file ./docker.env${SAG_RELEASE} -f apigw-cluster-ignite-ext-es-kib/docker-compose-${SAG_RELEASE}.yml down -v
```

## Deployment 1b: API Gateway 2-nodes Cluster (with Terracotta Bigmemory) connected to external ElasticSearch/Kibana 

Start stack:

```
docker compose --env-file ./docker.env${SAG_RELEASE} -f apigw-cluster-terracotta-ext-es-kib/docker-compose-${SAG_RELEASE}.yml up -d
```

Cleanup:

```
docker compose --env-file ./docker.env${SAG_RELEASE} -f apigw-cluster-terracotta-ext-es-kib/docker-compose-${SAG_RELEASE}.yml down -v
```

## Deployment 2: Developer Portal 2-nodes Cluster connected to external ElasticSearch

Start stack:

```
docker compose --env-file ./docker.env${SAG_RELEASE} -f devportal-cluster-ext-es/docker-compose.yml up -d
```

Cleanup:

```
docker compose --env-file ./docker.env${SAG_RELEASE} -f devportal-cluster-ext-es/docker-compose.yml down -v
```

## Deployment 3: Complete Load-Balanced (NGINX) API MGT Cluster (api gateway + devportal) connected to shared external ElasticSearch/Kibana 

This deployment includes:
 - a front load balancer (NGINX) to allow single point of access to the clustered APIGateway and Devportal components.
 - an API Gateway configurator job which updates the pasword and sets up few important configurations
 - an Developer Portal configurator job which updates the devportal pasword and sets up few important configurations 

URLs through NGINX load balancer:
 - API Gateway UI / API Calls: [http://localhost:8080](http://localhost:8080)
 - Developer Portal UI: [http://localhost:9090](http://localhost:9090)

NOTE 1: The updated password (set by the configurators) is: somethingnew

NOTE 2: since the components are fronted by the load balancer, the internal ports are not exposed (to mimic a real environment) - IF you want to access the APIGateway IS runtime (not typically needed), you'll need to expose the IS ports in the  [docker-compose file](./apimgt-cluster-complete/docker-compose-1015.yml)

Start stack:

```
docker compose --env-file ./docker.env${SAG_RELEASE} -f apimgt-cluster-complete/docker-compose-${SAG_RELEASE}.yml up -d
```

Cleanup:

```
docker compose --env-file ./docker.env${SAG_RELEASE} -f apimgt-cluster-complete/docker-compose-${SAG_RELEASE}.yml down -v
```
