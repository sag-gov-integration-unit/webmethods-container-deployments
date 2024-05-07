# Docker Sample Deployments - StreamSets

## pre-requisites

You need to set the following StreamSets Control Hub env variables so the SDC component can connect/comunicate to the right StreamSets Control Hub Deployment in the cloud

```
export STREAMSETS_DEPLOYMENT_SCH_URL=<YOUR STREAMSETS DEPLOYMENT ENDPOINT URL>
export STREAMSETS_DEPLOYMENT_ID=<YOUR STREAMSETS DEPLOYMENT ID>
export STREAMSETS_DEPLOYMENT_TOKEN=<YOUR STREAMSETS DEPLOYMENT TOKEN>
```

For the Oracle container, you need to get access thought the official repo, at https://container-registry.oracle.com/ and login to the oracle registry with your registry credentials

## Use Case 1: SDC with Oracle Change Data Capture (CDC) 

```
docker compose --env-file .env -f ./oracle_cdc/docker-compose.yml up -d
```

If you need to login to the Oracle container (sqlplus prompt):

```
docker exec -it <Oracle Container ID> sqlplus / as sysdba
```