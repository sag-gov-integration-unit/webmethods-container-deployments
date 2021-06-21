# Docker Sample Deployments - SoftwareAG webMethods Terracotta BigMemory

Requirements: 

1) Run all commands from this directory (due to volumes path mapping)
2) Make sure you save in this current directory valid licenses:
 - for "Terracotta" (used for APIGateway clustering), and name the file as "terracotta-license.key"

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