# Docker Sample Deployments - SoftwareAG webMethods API Portal

Sample deployments of webMethods API Portal using Docker / Docker-compose:

Requirement: 

1) Run all commands from this directory (due to volumes path mapping)
2) Make sure you save in this current directory valid licenses:
 - for "Api Portal", and name the file as "apiportal-licenseKey.xml"

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

## APIPortal Single Standalone Node

Start stack:

```
docker-compose --env-file ./configs/docker.env${SAG_RELEASE} -f apiportal-standalone/docker-compose.yml up -d
```

Cleanup:

```
docker-compose --env-file ./configs/docker.env${SAG_RELEASE} -f apiportal-standalone/docker-compose.yml down
```
