# Deploy the Traefik Ingress controller

## AWS EKS Specifics

IMPORTANT: Since the traefik ingress in this case will use an internal NLB, per https://docs.aws.amazon.com/eks/latest/userguide/network-load-balancing.html, the private subnets must be tagged with the following values: 
Key – kubernetes.io/role/internal-elb
Value – 1

## Install

helm repo add traefik https://helm.traefik.io/traefik
helm repo update

### Install in the namespace "traefik-v2"

kubectl create ns traefik
helm upgrade --install --namespace=traefik \
    traefik traefik/traefik \
    -f traefik-ingress.yaml

## Verify

kubectl --namespace=traefik port-forward $(kubectl get pods --namespace=traefik --selector "app.kubernetes.io/name=traefik" --output=name) 9000:9000

It can then be reached at: http://127.0.0.1:9000/dashboard/

## Cleanup

helm uninstall --namespace=traefik traefik
kubectl delete ns traefik