# webmethods Container Deployments in Kubernetes by Software AG Government Solutions 

## Pre-requisites 1

It's assume that you are already familiar with Amazon EKS and have access to an Amazon EKS environment to perform the deployments in these tutorials.

For more info, refer to [Getting started with Amazon EKS](https://docs.aws.amazon.com/eks/latest/userguide/getting-started.html)

## Optional: Move containers images to AWS ECR

Although not entirely required, it is "easier" for EKS to access the container images in an AWS ECR that is in the same AWS account (no need for pull secrets etc...)
If not done already, please review: [webmethods API Management in AWS Elastic Container Registry (ECR) by Software AG Government Solutions](../../aws_ecr/api_management/README.md)

## Deployments

Deployment in EKS mostly follow common Kubernetes deployment practices, so you'll find the sample deployments at:

[webmethods Container Deployments in Kubernetes by Software AG Government Solutions](../kubernetes/README.md)