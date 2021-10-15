# webmethods Container Deployments by Software AG Government Solutions 

A project with sample container deployment blueprints for the various SoftwareAG webMethods-based solutions.

## Docker Deployments

Currently available Docker container images and deployments:

- [webMethods API Gateway](./docker/apigateway/README.md)
- [webMethods API Portal](./docker/apiportal/README.md)
- [webMethods Microservice Runtime](./docker/msr/README.md)
- [webMethods Terracotta BigMemory](./docker/terracotta_bigmemory/README.md)


Note: By default, all deployments in this project are setup to use the protected "Software AG Government Solutions GitHub Container Registry" at: 

ghcr.io/softwareag-government-solutions/

If this must be changed, set the following variables to new registry:

```bash
export REG=newregistry/registrypath/
```
## Kubernetes Deployments

TODO