# Docker Sample Deployments - StreamSets

## pre-requisites

You need to set the following StreamSets Control Hub env variables so the SDC component can connect/comunicate to the right StreamSets Control Hub Deployment in the cloud

```
export STREAMSETS_DEPLOYMENT_SCH_URL=<YOUR STREAMSETS DEPLOYMENT ENDPOINT URL>
export STREAMSETS_DEPLOYMENT_ID=<YOUR STREAMSETS DEPLOYMENT ID>
export STREAMSETS_DEPLOYMENT_TOKEN=<YOUR STREAMSETS DEPLOYMENT TOKEN>
```

## Use Case 1: SDC with Oracle Change Data Capture (CDC) 

### First, start the stack:

```
docker compose --env-file .env -f ./oracle_cdc/docker-compose.yml up -d
```
