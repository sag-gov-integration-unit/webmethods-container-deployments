# webmethods APIGateway and APIPortal single-nodes in Kubernetes by Software AG Government Solutions 

IMPORTANT NOTE: This deployment is only for trying/testing the webMethods APIGateway/APIPortal capabilities in Kubernetes...and NOT a production-ready deployment.
Production-ready deployment is out of scope for this simple tutorial.

## Create demo namespace

```bash
kubectl create ns apimgt-demo1
```

## Apply:

```bash
kubectl apply --namespace=apimgt-demo1 -f apigateway-standalone.yaml
kubectl apply --namespace=apimgt-demo1 -f apigateway-configurator.yaml
kubectl apply --namespace=apimgt-demo1 -f apiportal-standalone.yaml
```

## Delete all

```bash
kubectl delete --namespace=apimgt-demo1 -f apiportal-standalone.yaml
kubectl delete --namespace=apimgt-demo1 -f apigateway-configurator.yaml
kubectl delete --namespace=apimgt-demo1 -f apigateway-standalone.yaml
```

And delete namepsace

```bash
kubectl delete namespace apimgt-demo1
```

## Troubleshooting

## View all:

```bash
kubectl get all          
```

### Get shell into pod

```bash
POD_NAME="webmethods-apiportal-standalone-8695dddbd5-78mh6"
kubectl --namespace=apimgt-demo1 exec --stdin --tty $POD_NAME -- /bin/bash
```

### Check the logs

```
kubectl logs -l app.kubernetes.io/name=webmethods-apigateway-standalone
```

or tail it:

```
kubectl logs -f --tail=-1 -l app.kubernetes.io/name=webmethods-apigateway-standalone
```