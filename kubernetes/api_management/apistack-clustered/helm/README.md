# webmethods APIGateway and APIPortal Clustered in Kubernetes - Using Helm Charts 

This page will walk through the deployment of a realistic scalable API Management cluster in your kubernetes environment:

 - 2 API Gateway runtime servers (clustered)
 - 2 Developer portal servers (clustered)
 - 2 Terracotta servers (clustered)
 - 3 Elastic Search servers (clustered)
 - 2 Kibana servers


## Prep steps

### Create demo namespace

```bash
export DEMO_NAMESPACE=apimgt-cluster-demo
kubectl create ns $DEMO_NAMESPACE
kubectl config set-context --current --namespace=$DEMO_NAMESPACE
```

### Add Elastic Operator (if not there alteady)

```bash
helm repo add elastic https://helm.elastic.co
helm repo update

helm install elastic-operator elastic/eck-operator -n elastic-system --create-namespace
```

### Add the Helm REPO

```bash
helm repo add saggov-helm-charts https://softwareag-government-solutions.github.io/saggov-helm-charts
helm repo update
```

### Add pull secrets for the container images

The container images in our GitHub Container Registry are not publically accessible. Upon access granted, you'll need to add your auth_token into a K8s secret entry for proper image pulling...
Here it is:

```bash
kubectl create secret docker-registry saggov-ghrc --docker-server=ghcr.io/softwareag-government-solutions --docker-username=mygithubusername --docker-password=mygithubreadtoken --docker-email=mygithubemail
```

where: 
mygithubusername = your github username
mygithubreadtoken = your github auth token with read access to the registry
mygithubemail = your github email

### Add license secrets for the container images

Each product require a valid license to operate. We'll add the valid licenses in K8s secrets so they can be used by the deployments.

```bash
kubectl create secret generic softwareag-webmethods-licenses \
  --from-file=terracotta-license=./licensing/terracotta-license.key \
  --from-file=apigateway-license=./licensing/apigateway-license.xml \
  --from-file=devportal-license=./licensing/devportal-license.xml
```

## Deploy/Detroy stack
### Deploy stack

```bash
/bin/sh deploy.sh $DEMO_NAMESPACE
```

### Delete stack

```bash
/bin/sh destroy.sh $DEMO_NAMESPACE
```

## Manual steps

### Add ElasticSearch stack

NOTE: The command below rely on Elastic Cloud on Kubernetes (ECK) available and installed in the cluster.
Elastic Cloud on Kubernetes (ECK) is a Kubernetes operator to orchestrate Elastic applications (Elasticsearch, Kibana, APM Server, Enterprise Search, Beats, Elastic Agent, and Elastic Maps Server) on Kubernetes. More info at https://www.elastic.co/guide/en/cloud-on-k8s/current/k8s-installing-eck.html

Once ECK is installed, simply run the following 2 commands to install the elastic stack:

```bash
kubectl --namespace $DEMO_NAMESPACE apply -f elasticsearch.yaml
kubectl --namespace $DEMO_NAMESPACE apply -f kibana.yaml
```

### Add Developer Portal stack

```bash
helm install --namespace $DEMO_NAMESPACE -f devportal.yaml webmethods-devportal saggov-helm-charts/webmethods-devportal
```

### Add Terracotta stack

```bash
helm install --namespace $DEMO_NAMESPACE -f terracotta.yaml webmethods-terracotta saggov-helm-charts/webmethods-terracotta
```

### Add API Gateway stack

```bash
helm install --namespace $DEMO_NAMESPACE -f apigateway.yaml webmethods-apigateway saggov-helm-charts/webmethods-apigateway
```

### Uninstall Steps

```bash
helm uninstall --namespace $DEMO_NAMESPACE webmethods-apigateway
helm uninstall --namespace $DEMO_NAMESPACE webmethods-terracotta
helm uninstall --namespace $DEMO_NAMESPACE webmethods-devportal

kubectl --namespace $DEMO_NAMESPACE delete -f elasticsearch.yaml
kubectl --namespace $DEMO_NAMESPACE delete -f kibana.yaml
```