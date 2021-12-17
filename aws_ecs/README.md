# webmethods Container Deployments in AWS Elastic Container Server (ECS) by Software AG Government Solutions 

Sample deployments to AWS ECS

## Pre-requisites 1

It's assume that you are already familiar with Amazon ECS and have access to an Amazon ECS environment to perform the deployments in these tutorials.

For more info, refer to [Getting started with Amazon ECS](https://aws.amazon.com/ecs/getting-started/)

## Pre-requisites 2

- Have an AWS account setup fo CLI access
- Have access to ECS/ECR services

## Pre-requisites 3

You should already have all the API Management images (with lcienses) already uplaoded to your AWS ECR registry.
If not, refer to [webMethods API Management](../private_registries/api_management/README.md)

## Get started quick with Base AWS Infrastructure

If you want to generate a quick base AWS environment ready for ECS, with a VPC, Subnets, ALB, and ECS cluster, refer to:
- [Base AWS ECS Infrastructure Cloudformation Template](./base_ecs_infra/README.md)

## Current ECS Sample Deployments

Currently available sample ECS deployments:

- [webMethods API Management](./api_management/README.md)
