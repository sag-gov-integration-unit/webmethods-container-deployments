# webmethods API Management in AWS Elastic Container Server (ECS) by Software AG Government Solutions 

This is a group of sample deployments for AWS Elastic Container Server (ECS) by Software AG Government Solutions.

## Step 1: SoftwareAG Licenses

Make sure you save a valid licenses in "./licensing" directory with the expected file name (due to volume mapping / dockerfile copying):

 - ApiGateway Advanced
   - expected filename: "./licensing/apigateway-licenseKey.xml"
 - API Portal (*Optional: only needed for the deployments involving API Portal product*)
   - expected filename: "./licensing/apiportal-licenseKey.xml"
 - Terracotta (*Optional: only needed for the deployments involving API Gateway clustering*)
   - expected filename: "./licensing/terracotta-license.key"
 - Microgateway (*Optional: only needed for the deployments involving Microgateway product*)
   - expected filename: "./licensing/microgateway-licenseKey.xml"

## Step 2: Load webMethods Major Versions

The webMethods major versions flavors (wM 10.5, wM 10.7, etc...) are pre-defined in the ./configs folder, in files named "docker.env<version>"
To chose what version to load, you simply need to load the right environment file with your docker-compose command.

To help with that, you can set the following Environment variable, which will then be used in the docker-compose commands on this page:
If the variable is not defined, the commands will then automatically load the ./configs/docker.env file which is always set to the latest SAG RELEASE.

```bash
export SAG_RELEASE=107
```

or 

```bash
export SAG_RELEASE=105
```

## Step 3: Build and Push images to ECR

Let's push our images to the AWS Elastic Container Registry (ECR) for ease of deployment into AWS ECS

### Login to AWS ECR

```
export AWS_REGION=us-east-1
export AWS_ECR=<ECR>.amazonaws.com
```

```
aws ecr get-login-password --region ${AWS_REGION} | docker login --username AWS --password-stdin ${AWS_ECR}
```

### Build the images

This mostly downloads the images from existing non-AWS registry, add licenses as needed, and retag them with the AWS ECR registry so we can push them into AWS ECR.

IMPORTANT NOTE: make sure you don't forget the "/" at the end of REG_ECR value...it's expected in the docker compose build.

```
export REG_ECR=${AWS_ECR}/
docker-compose --env-file ./configs/docker.env${SAG_RELEASE} -f docker-compose-build.yml build
```

### Create the repos in AWS ECR

Docker-compose will not create the AWS ECR repository when you push...so we need to pre-create these repository in AWS ECR first (one-time setup)

- webmethods-apigateway-standalone
- webmethods-apigateway-configurator
- webmethods-apiportal
- webmethods-sample-apis-bookstore
- webmethods-sample-apis-covid
- webmethods-sample-apis-uszip

### Push the images to ECR

```
docker-compose --env-file ./configs/docker.env${SAG_RELEASE} -f docker-compose-build.yml push
```

At this point, you should have all the images in AWS ECR, ready to be used in our AWS ECR deployments.

### Deploy the products

#### apigateway-with-apiportal

Pick the deployment type you want to try...with more detailed instructions:

- [dockercompose-to-ecs](./apigateway-with-apiportal/dockercompose-apigateway-with-apiportal/README.md)
- [cloudformation-to-ecs](./apigateway-with-apiportal/cloudformation/README.md)
