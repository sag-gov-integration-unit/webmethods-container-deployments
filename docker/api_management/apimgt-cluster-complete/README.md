# Complete Load-Balanced (NGINX) API MGT Cluster (api gateway + devportal) connected to shared external ElasticSearch/Kibana 

## Deployment Details

This deployment includes:
 - a front load balancer (NGINX) to allow single point of access to the clustered APIGateway and Devportal components.
 - an API Gateway configurator job which updates the pasword and sets up few important configurations
 - an Developer Portal configurator job which updates the devportal pasword and sets up few important configurations 

URLs through NGINX load balancer:
 - API Gateway UI / API Calls: [http://localhost:8080](http://localhost:8080)
 - Developer Portal UI: [http://localhost:9090](http://localhost:9090)

NOTE 1: The updated password (set by the configurators) is: somethingnew

NOTE 2: since the components are fronted by the load balancer, the internal ports are not exposed (to mimic a real environment) - IF you want to access the APIGateway IS runtime (not typically needed), you'll need to expose the IS ports in the  [docker-compose file](./apimgt-cluster-complete/docker-compose-1015.yml)

## Sample APIs

http://localhost:5555/gateway/uszip/1.0/uszip/findZip/Bethesda/MD

http://localhost:5555/gateway/bookstore/1.0/books/1001