# webmethods API Management in AWS Elastic Container Server (ECS) by Software AG Government Solutions 

This is a group of sample deployments for AWS Elastic Container Server (ECS) by Software AG Government Solutions.

## Pre-requisite 1 - All needed SAG API Management Images in your ECR registry

You should already have all the API Management images (with lcienses) already uplaoded to your AWS ECR registry.
If not, refer to [webmethods API Management in your Private Registry by Software AG Government Solutions ](../../private_registries/api_management/README.md)

## Pre-requisite 2 - Base AWS Infrastructure created

To facilitate the Tutorial, we have created a base infrastructure Cloudformation stack that will create the base components needed for easy testing:
 - 1 sample VPC
 - Few subnets in the VPC
 - 1 load balancer
 - 1 ECS cluster

Refer to [Base AWS ECS Infrastructure for ECS Tutorials > Deploy](../base_ecs_infra/README.md) to run...

## Deploy the API Management container stack into ECS (using cloudformation)

First, export the values needed like the AWS REGION and the AWS Registry (ECR) that contains the SAG images:
```bash
export AWS_REGION=us-east-1
export AWS_ECR=<ECR>.amazonaws.com
```

Then, Deploy:

```bash
/bin/sh deploy.sh "$AWS_ECR"
```

Once deployed, Product UIs will be available at (the script will actually give you the accurate URL):
 - APIGateway UI URL: http://<AWS_LB>:9072
 - Portal UI URL: http://<AWS_LB>:18101

## Delete stack

```bash
/bin/sh destroy.sh
```

## Delete Base Infrastructure

If you're done, don't forget to destroy the base infrastructure too:

Refer to [Base AWS ECS Infrastructure for ECS Tutorials > Destroy](../base_ecs_infra/README.md) for detais on that.
