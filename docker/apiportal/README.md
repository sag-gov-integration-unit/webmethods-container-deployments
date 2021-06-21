# Docker Sample Deployments - API Portal

Testing the API Portal container using raw Docker:

## Testing apiportal Standalone

Start stack:

```
docker-compose -f sag-apiportal/docker-compose.yml up -d
```

Cleanup:

```
docker-compose -f sag-apiportal/docker-compose.yml down
```

## Testing apiportal Standalone with Volumes

Start stack:

```
docker-compose -f sag-apiportal-volumes/docker-compose.yml up -d
```

Cleanup:

```
docker-compose -f sag-apiportal-volumes/docker-compose.yml down
```