# webmethods Container Deployments in Kubernetes by Software AG Government Solutions 

## Pre-requisites 1

It's assume that you are already familiar with Amazon EKS and have access to an Amazon EKS environment to perform the deployments in these tutorials.

For more info, refer to [Getting started with Amazon EKS](https://docs.aws.amazon.com/eks/latest/userguide/getting-started.html)

## Optional: Move containers images to AWS ECR

It's totally fine to leverage "pull secrets" to allow kubernetes to pull images from any private registry (like the Software AG Government solutions one at which details are outlined in https://softwareag-government-solutions.github.io/saggov-containers/)

But since EKS will generally be able to pull images directly from an ECR in the same account (no need for pull secrets etc...), and since you may want to modify the base images a bit based on your own requirements, an option could certainly be that you push the images (modified or not) to your own registry like ECR...

If interested in doing that, please review: [webmethods in your Private Registry](../private_registries/README.md)

## Deployments

Deployment in EKS mostly follow common Kubernetes deployment practices, so you'll find the sample deployments in the common Kubernetes folder at:

[webmethods Container Deployments in Kubernetes by Software AG Government Solutions](../kubernetes/README.md)