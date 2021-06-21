# Docker Sample Deployments - SoftwareAG webMethods Terracotta BigMemory

Requirements: 

1) Run all commands from this directory (due to volumes path mapping)
2) Make sure you save in this current directory valid licenses:
 - for "Terracotta" (used for APIGateway clustering), and name the file as "terracotta-license.key"

Note: 
By default, all deployments use the latest image version in the current branch (ie. "dev-4.3.9-latest"). 
In most cases, that should be good... 
But if this must be changed, set the following ENV variables to the new desired tag version, ie:
```
export TAG_TERRACOTTA=dev-4.3.9-2019 
```
## Terracotta Standalone

Start stack:

```
docker-compose -f terracotta_bigmemory_standalone/docker-compose.yml up -d
```

Cleanup:

```
docker-compose -f terracotta_bigmemory_standalone/docker-compose.yml down
```

## Terracotta Standalone with Volume Persistence

Start stack:

```
docker-compose -f terracotta_bigmemory_standalone_persistence/docker-compose.yml up -d
```

Cleanup:

```
docker-compose -f terracotta_bigmemory_standalone_persistence/docker-compose.yml down --volumes
```

## Terracotta cluster

Start stack:

```
docker-compose -f terracotta_bigmemory_cluster/docker-compose.yml up -d
```

Cleanup:

```
docker-compose -f terracotta_bigmemory_cluster/docker-compose.yml down
```

## Terracotta cluster with Volume Persistence

Start stack:

```
docker-compose -f terracotta_bigmemory_cluster_persistence/docker-compose.yml up -d
```

Cleanup:

```
docker-compose -f terracotta_bigmemory_cluster_persistence/docker-compose.yml down --volumes
```