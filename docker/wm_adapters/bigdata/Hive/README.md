# Hive setup to test the wM BigData Hive adapter

## Launch the full stack

```
docker-compose --env-file ./sag.1015.env up -d 
```

## Load IS package

IS UI at: http://localhost:5555/

Working connection and code by loading into IS the package at ./packages/BigdataTesting.zip
Copy the package into ./work/is/replicate/inbound, and load the package in IS.

Hive connection uses the wM Datasource: "wm.jdbcx.hive.HiveDataSource"

==> re-enter the password for the user "user01" (=password1) for the connection to work.

## Login to relevant containers

docker exec -it hive-server /bin/bash

docker exec -it integrationserver /bin/bash

## References for Hive initial setup

To load the employee table / data, follow:
https://hshirodkar.medium.com/apache-hive-on-docker-4d7280ac6f8e

Notes about LDAP setup:
https://cwiki.apache.org/confluence/display/Hive/User+and+Group+Filter+Support+with+LDAP+Atn+Provider+in+HiveServer2

Another sample repo for extras...
https://github.com/big-data-europe/docker-hive

## Some misc notes about Hive JDBC HiveDataSource

==> not working so far...

It says:

Caused by: org.apache.hive.jdbc.JdbcUriParseException: Bad URL format: Missing prefix jdbc:hive2://
	at org.apache.hive.jdbc.Utils.parseURL(Utils.java:289)
	at org.apache.hive.jdbc.HiveConnection.<init>(HiveConnection.java:133)
	at org.apache.hive.jdbc.HiveDataSource.getConnection(HiveDataSource.java:61)
	... 42 more

### Hive JDBC "uber" jars

https://github.com/timveil/hive-jdbc-uber-jar/releases/tag/v1.0-2.3.4

NOTE: Copying jars out of the hive server

docker cp hive-server:/opt/hive/lib ./work/hive/

### Connection params

Datasource: org.apache.hive.jdbc.HiveDataSource

jdbc:hive2://hive-server:10001/testdb;ssl=false;LogLevel=6;LogPath=/tmp/logs;AuthMech=3;transportMode=http;httpPath=cliservice;UID=test1;PWD=Password1;

jdbc:hive2://hive-server:10001/testdb;SSL=1;SSLTrustStore=/home/keystore-cdp/cm-auto-global_truststore.jks;SSLTrustStorePwd=xxxx;LogLevel=6;LogPath=/tmp/logs;AuthMech=3;UID=test1;PWD=Password1;transportMode=http;httpPath=cliservice
