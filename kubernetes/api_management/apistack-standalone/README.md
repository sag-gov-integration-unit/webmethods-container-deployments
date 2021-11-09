# webmethods APIGateway and APIPortal single-nodes in Kubernetes by Software AG Government Solutions 

IMPORTANT NOTE: This deployment is only for trying/testing the webMethods APIGateway/APIPortal capabilities in Kubernetes...and NOT a production-ready deployment.
Production-ready deployment is out of scope for this simple tutorial.

## Create demo namespace

```bash
kubectl create ns apimgt-demo1
```

## Create secrets for the demo

We'll be using this secret to update the passwords for API gateway / API Portal:

```bash
echo -n 'SuperSecretPassword123!' > /tmp/password.txt
kubectl create secret generic apimgt-admin-secret \
   --from-file=password=/tmp/password.txt \
   --namespace apimgt-demo1
```

Verify:

```bash
kubectl describe secrets/apimgt-admin-secret \
   --namespace apimgt-demo1
```

## Prep the manifests

In order to not hardcode some key values in the manifest, you'll need to first update the manifest with your own values.
Of course, such mechanism would be taken care by other K8 Tooling like "helm", "kustomize", etc...
But for now, in order to keep things "simple", we'll leave it up to you to replace with the right values before deploying the manifests.

A naive way could be to use SED to replace the needed variables before the deployment...

```bash
AWS_ECR=<your ECR>
TAG_APIGATEWAY=dev-10.7.7-1
TAG_APIGATEWAY_CONFIGURATOR=configurator-10.7.7-3
TAG_APIPORTAL=dev-10.7.4-2
```

then:

```bash
mkdir -p ./deploy

sed "s/\${AWS_ECR}/${AWS_ECR}\//g" apigateway-standalone.yaml.template > ./deploy/apigateway-standalone.yaml
sed -i.bak "s/\${TAG_APIGATEWAY}/${TAG_APIGATEWAY}/g" ./deploy/apigateway-standalone.yaml

sed "s/\${AWS_ECR}/${AWS_ECR}\//g" apiportal-standalone.yaml.template > ./deploy/apiportal-standalone.yaml
sed -i.bak "s/\${TAG_APIPORTAL}/${TAG_APIPORTAL}/g" ./deploy/apiportal-standalone.yaml

sed "s/\${AWS_ECR}/${AWS_ECR}\//g" apigateway-configurator.yaml.template > ./deploy/apigateway-configurator.yaml
sed -i.bak "s/\${TAG_APIGATEWAY_CONFIGURATOR}/${TAG_APIGATEWAY_CONFIGURATOR}/g" ./deploy/apigateway-configurator.yaml
```

## Apply:

```bash
kubectl apply --namespace=apimgt-demo1 -f ./deploy/apigateway-standalone.yaml
kubectl apply --namespace=apimgt-demo1 -f ./deploy/apigateway-configurator.yaml
kubectl apply --namespace=apimgt-demo1 -f ./deploy/apiportal-standalone.yaml
```

## Access the UIs

Due to the values used in the Ingress, the following 2 hostname MUST be used to access the deployment:

API Gateway: http://webmethods-apigateway.demo1.apimgt.cloud/apigatewayui
User: Administrator
Password: <the one added to the secret in initial step>

API Portal: http://webmethods-apiportal.demo1.apimgt.cloud
User: system
Password: <the one added to the secret in initial step>

NOTE (out of scope): If these DNS are not accessible in your AWS environment, you can either add them to your AWS S3 or simply update your local HOSTS file accordingly (linux based system at /etc/hosts)

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