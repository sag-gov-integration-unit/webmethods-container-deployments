# webmethods Container Deployments in AWS Elastic Container Server (ECS) by Software AG Government Solutions 

Sample deployments to AWS ECS

## Pre-requisites 1

It's assume that you are already familiar with Amazon ECS and have access to an Amazon ECS environment to perform the deployments in these tutorials.

For more info, refer to [Getting started with Amazon ECS](https://aws.amazon.com/ecs/getting-started/)

## Pre-requisites 2

- Have an AWS account setup fo CLI access
- Have access to ECS/ECR services
- Have access to Software Gov Solutions Github Registry at [ghcr.io/softwareag-government-solutions/](https://github.com/orgs/softwareag-government-solutions/packages)
- Have valid licenses (trial or full) for SoftwareAG products

If you need help, contact [Software AG Government Solutions](https://www.softwareaggov.com/) at [info@softwareaggov.com](mailto:info@softwareaggov.com) 

## AWS Infrastructure

If you want to generate a quick base AWS environment ready for ECS, with a VPC, Subnets, ALB, and ECS cluster, go to [Common AWS ECS Infrastructure Cloudformation Template](./base_ecs_infra/README.md)

## Current ECS Sample Deployments

Currently available sample ECS deployments:

- [webMethods API Management](./api_management/README.md)
