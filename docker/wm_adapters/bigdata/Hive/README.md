# Hive setup to test the wM BigData Hive adapter

## References:

https://hshirodkar.medium.com/apache-hive-on-docker-4d7280ac6f8e

https://github.com/big-data-europe/docker-hive

## Load working package

==> see working connection and code by loading into IS the package at ./packages/BigdataTesting.zip

It uses the wM Datasource: wm.jdbcx.hive.HiveDataSource

## Some misc notes

### Login to relevant containers:

docker exec -it hive-server /bin/bash

docker exec -it integrationserver /bin/bash

### Hive JDBC "uber" jars

https://github.com/timveil/hive-jdbc-uber-jar/releases/tag/v1.0-2.3.4

NOTE: Copying jars out of the hive server

docker cp hive-server:/opt/hive/lib ./work/hive/

### Connection params

#### working datasource

Datasource: wm.jdbcx.hive.HiveDataSource


#### datasource with issues (so far)

Datasource: org.apache.hive.jdbc.HiveDataSource

jdbc:hive2://hive-server:10001/testdb;ssl=false;LogLevel=6;LogPath=/tmp/logs;AuthMech=3;transportMode=http;httpPath=cliservice;UID=test1;PWD=Password1;

jdbc:hive2://hive-server:10001/testdb;SSL=1;SSLTrustStore=/home/keystore-cdp/cm-auto-global_truststore.jks;SSLTrustStorePwd=xxxx;LogLevel=6;LogPath=/tmp/logs;AuthMech=3;UID=test1;PWD=Password1;transportMode=http;httpPath=cliservice
