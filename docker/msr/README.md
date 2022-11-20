# Docker Sample Deployments - SoftwareAG webMethods Microservice Runtime

Sample deployments of webMethods Microservice Runtime using Docker / Docker-compose:

## Requirements

1) Run all commands from this directory (due to volumes path mapping)
   
2) Make sure you save a *valid licenses* with expected name (for proper volume mapping in docker) in the "../licensing" directory:

 - "Microservice Runtime"
   - Expected filename: "../licensing/msr-licenseKey.xml"

## webMethods Major Versions

The webMethods major versions flavors (wM 10.5, wM 10.7, etc...) are pre-defined in the ./configs folder, in files named "docker.env<version>"
To chose what version to load, you simply need to load the right environment file with your docker-compose command.

```bash
export SAG_RELEASE=1011
```

or 

```bash
export SAG_RELEASE=1015
```

## MSR Core

Start stack:

```
docker-compose --env-file ./docker.env${SAG_RELEASE} -f msr-core/docker-compose.yml up -d
```

Cleanup:

```
docker-compose --env-file ./docker.env${SAG_RELEASE} -f msr-core/docker-compose.yml down
```

## MSR JDBC

Start stack:

```
docker-compose --env-file ./docker.env${SAG_RELEASE} -f msr-jdbc/docker-compose.yml up -d
```

Cleanup:

```
docker-compose --env-file ./docker.env${SAG_RELEASE} -f msr-jdbc/docker-compose.yml down
```

## MSR Cloudstreams

Start stack:

```
docker-compose --env-file ./docker.env${SAG_RELEASE} -f msr-cloudstreams/docker-compose.yml up -d
```

Cleanup:

```
docker-compose --env-file ./docker.env${SAG_RELEASE} -f msr-cloudstreams/docker-compose.yml down
```
