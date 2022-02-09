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

### Add the Helm REPO

```bash
helm repo add saggov-helm-charts https://softwareag-government-solutions.github.io/saggov-helm-charts
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

NOTE: The command below rely on ECK available on the cluster.
Elastic Cloud on Kubernetes (ECK) is a Kubernetes operator to orchestrate Elastic applications (Elasticsearch, Kibana, APM Server, Enterprise Search, Beats, Elastic Agent, and Elastic Maps Server) on Kubernetes. More info at https://www.elastic.co/guide/en/cloud-on-k8s/current/k8s-installing-eck.html

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

## Uninstall Steps

```bash
helm uninstall --namespace $DEMO_NAMESPACE webmethods-apigateway
helm uninstall --namespace $DEMO_NAMESPACE webmethods-terracotta
helm uninstall --namespace $DEMO_NAMESPACE webmethods-devportal

kubectl --namespace $DEMO_NAMESPACE delete -f elasticsearch.yaml
kubectl --namespace $DEMO_NAMESPACE delete -f kibana.yaml
```