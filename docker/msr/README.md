# Docker Sample Deployments - SoftwareAG webMethods Microservice Runtime

Sample deployments of webMethods Microservice Runtime using Docker / Docker-compose:

## Requirements

1) Run all commands from this directory (due to volumes path mapping)
   
2) Make sure you save a *valid licenses* with expected name (for proper volume mapping in docker) in the "./licensing" directory:

 - "Microservice Runtime"
   - Expected filename: "./licensing/msr-licenseKey.xml"

## webMethods Major Versions

The webMethods major versions flavors (wM 10.5, wM 10.7, etc...) are pre-defined in the ./configs folder, in files named ".env<version>"
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

## MSR Core

Start stack:

```
docker-compose --env-file ./configs/docker.env${SAG_RELEASE} -f msr-core/docker-compose.yml up -d
```

Cleanup:

```
docker-compose --env-file ./configs/docker.env${SAG_RELEASE} -f msr-core/docker-compose.yml down
```

## MSR JDBC

Start stack:

```
docker-compose --env-file ./configs/docker.env${SAG_RELEASE} -f msr-jdbc/docker-compose.yml up -d
```

Cleanup:

```
docker-compose --env-file ./configs/docker.env${SAG_RELEASE} -f msr-jdbc/docker-compose.yml down
```

## MSR Cloudstreams

Start stack:

```
docker-compose --env-file ./configs/docker.env${SAG_RELEASE} -f msr-cloudstreams/docker-compose.yml up -d
```

Cleanup:

```
docker-compose --env-file ./configs/docker.env${SAG_RELEASE} -f msr-cloudstreams/docker-compose.yml down
```
