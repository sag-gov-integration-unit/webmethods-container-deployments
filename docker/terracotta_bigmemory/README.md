# Docker Sample Deployments - SoftwareAG webMethods Terracotta BigMemory

Requirements: 

1) Run all commands from this directory (due to volumes path mapping)
2) Make sure you save a *valid licenses* with expected name (for proper volume mapping in docker) in the "./licensing" directory:
   
 - for "Terracotta" (used for APIGateway clustering), and name the file as "../licensing/terracotta-license.key"

## Bigmemory Versions

The webMethods major versions flavors (bigmemory 43, 44, etc...) are pre-defined in the files named "docker.env<version>". To chose what version to load, you simply need to load the right environment file with your docker-compose command.

To help with that, you can set the following Environment variable, which will then be used in the docker-compose commands on this page:

```bash
export BIGMEMORY_RELEASE=44
```

## Terracotta Standalone

Start stack:

```
docker-compose --env-file ./docker.env${BIGMEMORY_RELEASE} -f terracotta_bigmemory_standalone/docker-compose.yml up -d
```

Cleanup:

```
docker-compose --env-file ./docker.env${BIGMEMORY_RELEASE} -f terracotta_bigmemory_standalone/docker-compose.yml down
```

## Terracotta Standalone with Volume Persistence

Start stack:

```
docker-compose --env-file ./docker.env${BIGMEMORY_RELEASE} -f terracotta_bigmemory_standalone_persistence/docker-compose.yml up -d
```

Cleanup:

```
docker-compose --env-file ./docker.env${BIGMEMORY_RELEASE} -f terracotta_bigmemory_standalone_persistence/docker-compose.yml down --volumes
```

## Terracotta cluster

Start stack:

```
docker-compose --env-file ./docker.env${BIGMEMORY_RELEASE} -f terracotta_bigmemory_cluster/docker-compose.yml up -d
```

Cleanup:

```
docker-compose --env-file ./docker.env${BIGMEMORY_RELEASE} -f terracotta_bigmemory_cluster/docker-compose.yml down
```

## Terracotta cluster with Volume Persistence

Start stack:

```
docker-compose --env-file ./docker.env${BIGMEMORY_RELEASE} -f terracotta_bigmemory_cluster_persistence/docker-compose.yml up -d
```

Cleanup:

```
docker-compose --env-file ./docker.env${BIGMEMORY_RELEASE} -f terracotta_bigmemory_cluster_persistence/docker-compose.yml down --volumes
```