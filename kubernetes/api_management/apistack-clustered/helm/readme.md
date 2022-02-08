# webmethods APIGateway and APIPortal Clustered in Kubernetes - Using Helm Charts 

## Create demo namespace

```bash
export DEMO_NS=apimgt-cluster-demo
kubectl create ns $DEMO_NS
kubectl config set-context --current --namespace=$DEMO_NS
```

## Add ElasticSearch stack

NOTE: The command below rely on ECK available on the cluster.
Elastic Cloud on Kubernetes (ECK) is a Kubernetes operator to orchestrate Elastic applications (Elasticsearch, Kibana, APM Server, Enterprise Search, Beats, Elastic Agent, and Elastic Maps Server) on Kubernetes. More info at https://www.elastic.co/guide/en/cloud-on-k8s/current/k8s-installing-eck.html

```bash
kubectl --namespace $DEMO_NS apply -f elasticsearch.yaml
kubectl --namespace $DEMO_NS apply -f kibana.yaml
```

## Add Terracotta stack

## Create secrets for the demo

We'll be using this secret to update the passwords for API gateway / API Portal:

```bash
echo -n 'SuperSecretPassword123!' > /tmp/password.txt
kubectl create secret generic apimgt-admin-secret \
   --from-file=password=/tmp/password.txt \
   --namespace $DEMO_NS
```

Verify:

```bash
kubectl describe secrets/apimgt-admin-secret \
   --namespace $DEMO_NS
```



helm repo add elastic https://helm.elastic.co

