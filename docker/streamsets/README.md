# Docker Sample Deployments - StreamSets

## pre-requisites

You need to set the following StreamSets Control Hub env variables so the SDC component can connect/communicate to the right StreamSets Control Hub Deployment in the cloud

```
export STREAMSETS_DEPLOYMENT_SCH_URL=<YOUR STREAMSETS DEPLOYMENT ENDPOINT URL>
export STREAMSETS_DEPLOYMENT_ID=<YOUR STREAMSETS DEPLOYMENT ID>
export STREAMSETS_DEPLOYMENT_TOKEN=<YOUR STREAMSETS DEPLOYMENT TOKEN>
```

For the Oracle container, you need to get access thought the official repo, at https://container-registry.oracle.com/ and login to the oracle registry with your registry credentials

```
docker login container-registry.oracle.com
```

## Use Case 1: SDC with Oracle Change Data Capture (CDC) 

NOTE: The Oracle container will take 10+ minutes to start the first time (due to various initializations steps) BUT once the Oracle instance has started once, it will start much quicker anytime afterwards (1 min or so)

```
docker compose --env-file .env -f ./oracle_cdc/docker-compose.yml up -d
```

If you need to login to the Oracle container (sqlplus prompt):

As SYSDBA:
```
docker exec -it <Oracle Container ID> sqlplus / as sysdba
```

As StreamSets user:

** NOTE: streamsets password is set in the inti script at ./oracle_inits/1-setup-cdc.sql

```
docker exec -it <Oracle Container ID> sqlplus streamsets/WElcome123#@orclpdb1
```

To shut down the stack (but keeping the data in the volume):
```
docker compose --env-file .env -f ./oracle_cdc/docker-compose.yml down
```

To completely clean the stack, including the data in the volume:

```
docker compose --env-file .env -f ./oracle_cdc/docker-compose.yml down -v
```