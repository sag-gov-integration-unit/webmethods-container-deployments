# webmethods API Management in AWS Elastic Container Registry (ECR) by Software AG Government Solutions 

Let's push our images to the AWS Elastic Container Registry (ECR)

## Pre-requisites

- Have an AWS account setup fo CLI access
- Have access to ECR services

## Login to AWS ECR

```bash
export AWS_REGION=us-east-1
export AWS_ECR=<ECR>.amazonaws.com
```

```bash
aws ecr get-login-password --region ${AWS_REGION} | docker login --username AWS --password-stdin "${AWS_ECR}"
```

## Create the repos in AWS ECR

Docker will not create the AWS ECR repository when you push...so we need to pre-create these repository in AWS ECR first (one-time setup)

- apigateway
- apigateway-minimal
- webmethods-microgateway
- webmethods-apigateway-configurator
- webmethods-apigateway-deployer-sampleapis
- devportal (only for 10.11 and above releases)
- webmethods-devportal-configurator (only for 10.11 and above releases)
- webmethods-sample-apis-bookstore
- webmethods-sample-apis-uszip

## Push the images to AWS ECR

Push all the new images:

```bash
/bin/sh publish.sh "<ECR>.amazonaws.com"
```