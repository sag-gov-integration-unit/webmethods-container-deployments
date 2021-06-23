# webmethods Container Deployments in AWS Elastic Container Server (ECS) by Software AG Government Solutions 

Sample deployments to AWS ECS

## Pre-requisites

- Have an AWS account setup fo CLI access
- Have access to ECS/ECR services


```
aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 815840818766.dkr.ecr.us-east-1.amazonaws.com
```