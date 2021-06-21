# Docker Sample Deployments - SoftwareAG webMethods Terracotta BigMemory

Requirement: make sure you download a valid license for Terracotta BigMemory and put it in this directory, named as "terracotta-license.key"

By default, all deployments use:
- Protected Docker registry: harbor.saggs.cloud/library/
- Terracotta BigMemory version tag: "dev-4.3.9-latest"

If these must be changed, set the following variables to new registry or tag version:
```
export REG=
export TAG_TERRACOTTA=
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