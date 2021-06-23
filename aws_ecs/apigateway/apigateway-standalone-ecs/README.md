# webmethods ApiGateway in AWS Elastic Container Server (ECS) by Software AG Government Solutions 

Sample deployments to AWS ECS

## Pre-requisites

First, let's push our images to the AWS Elastic Container Registry (ECR).

Do do so:

1) login to ECR:

```
aws ecr get-login-password --region ${REGION} | docker login --username AWS --password-stdin ${REGISTRY}
```

2) Build the images:

```
docker-compose -f docker-compose-build.yml build
```

2) Create the repos in AWS ECR

Create the 2 needed repos in ECR:
- webmethods-apigateway-reverseproxy
- webmethods-apigateway-standalone

3) Push the images:

```
docker-compose -f docker-compose-build.yml push
```