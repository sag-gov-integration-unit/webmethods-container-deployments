# webmethods Container Deployments by Software AG Government Solutions 

A project with sample container deployment blueprints for the various SoftwareAG webMethods-based solutions.

## Docker Deployments

Note: By default, all deployments use the following protected Docker registry: harbor.saggs.cloud/library/

If this must be changed, set the following variables to new registry:
```
export REG=newregistry/registrypath
```

Currently available Docker container images and deployments:

- [webMethods API Gateway](./docker/apigateway/README.md)
- [webMethods API Portal](./docker/apiportal/README.md)
- [webMethods Terracotta](./docker/terracotta_bigmemory/README.md)

## Kubernetes Deployments

TODO