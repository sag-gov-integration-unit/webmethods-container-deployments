# Docker Sample Deployments - SoftwareAG webMethods API Portal

Sample deployments of webMethods API Portal using Docker / Docker-compose:

Requirement: 

1) Run all commands from this directory (due to volumes path mapping)
2) Make sure you save in this current directory valid licenses:
 - for "Api Portal", and name the file as "licenseKey.xml"

## APIPortal Single Standalone Node

Start stack:

```
docker-compose -f apiportal-standalone/docker-compose.yml up -d
```

Cleanup:

```
docker-compose -f apiportal-standalone/docker-compose.yml down
```
