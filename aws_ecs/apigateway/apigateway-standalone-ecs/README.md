# webmethods ApiGateway in AWS Elastic Container Server (ECS) by Software AG Government Solutions 

This is a sample webMethods API Gateway Standalone deployment with NGINX reverse-proxy frontend and 3 backend microservices APIs to be able to test the API Gateway functionnalities.
Components deployed:
 - 1 webMethods APIGateway 10.7 standalone
 - 1 NGINX reverse proxy
 - 3 sample Microservice APIs (for testing purposes)
 - 1 load runner (to generate small traffic on the gateway)

## Pre-requisite 0: Run diorectory

Run all commands from this directory (due to volumes path mapping)

## Pre-requisite 1: SoftwareAG Licenses

Make sure you save a valid licenses in "licensing" directory with the expected file name (due to volume mapping / dockerfile copying):

 - ApiGateway Advanced
   - expected filename: "./licensing/apigateway-licenseKey.xml"
 - API Portal (*Optional: only needed for the deployments involving API Portal product*)
   - expected filename: "./licensing/apiportal-licenseKey.xml"
 - Terracotta (*Optional: only needed for the deployments involving API Gateway clustering*)
   - expected filename: "./licensing/terracotta-license.key"
 - Microgateway (*Optional: only needed for the deployments involving Microgateway product*)
   - expected filename: "./licensing/microgateway-licenseKey.xml"

## Pre-requisite 2: Build and Push images to ECR

First, let's push our images to the AWS Elastic Container Registry (ECR).

Do do so:

1) login to ECR:

```
export REGION=us-east-1
export REGISTRY=some_ecr_registry
```

```
aws ecr get-login-password --region ${REGION} | docker login --username AWS --password-stdin ${REGISTRY}
```

2) Build the images:

NOTE: this mostly downloads the images from existing non-AWS registry, add licenses as needed, and retag them with the AWS ECR registry so we can push them into AWS ECR.

```
docker-compose build
```

3) Create the repos in AWS ECR

Docker-compose will not create the AWS ECR repository when you push...so we need to pre-create these repository in AWS ECR first (one-time setup) 
- webmethods-apigateway-reverseproxy
- webmethods-apigateway-standalone
- webmethods-apigateway-configurator
- webmethods-sample-apis-bookstore
- webmethods-sample-apis-covid
- webmethods-sample-apis-uszip

4) Push the images:

```
docker-compose push
```

## Pre-requisite 3: Create Docker ECS context

If you have already installed and configured the AWS CLI, the setup command lets you select an existing AWS profile to connect to Amazon. Otherwise, you can create a new profile by passing an AWS access key ID and a secret access key. Finally, you can configure your ECS context to retrieve AWS credentials by AWS_* environment variables, which is a common way to integrate with third-party tools and single-sign-on providers.

Create ECS context for AWS:

```
docker context create ecs myecscontext
```

If your ECS context was already created, simple use it by running:

```
docker context use myecscontext
```

Make sure the context is actually set by listing them. A "*" annotation beside the context name will show you which context is currently selected (should be your ECS context by now)

```
docker context list

> myecscontext *      ecs
```
## Pre-requisite 4: Create AWS Components

Because cloud operators / architects generally want extra control on the AWS items created, we have structured our docker-compose deployment file to expect the following 3 items to be externally created:
 - AWS VPC (to host the ECS cluster) 
 - AWS ECS cluster (to create the type of ECS cluster you want)
 - AWS Load balancer (to route the traffic to the ECS cluster) 

So in our docker-compose, we allow you to specify the IDs for the following 3 pre-created AWS components by setting up few variables in the .env file:
 - x-aws-vpc: ${TARGET_VPC}
 - x-aws-loadbalancer: ${TARGET_LOADBALANCER}
 - x-aws-cluster: ${TARGET_ECS_CLUSTER}

Overall, use the right IDs to your own resources in AWS.

## Load the deployment into ECS using compose

Simply run:

```
docker compose up -d
```

NOTEs: 
It's important to understand that the "docker compose" command really creates an "AWS CloudFormation" template (AWS automation template), uploads it to AWS, and runs it.

See it for yourself at: [Docker Compose Generated CloudFormation Template](./cloudformation/docker-compose-cloudformation-generated.yaml)

What this means is that at the end of the "docker compose" command above, the environment is not yet fully created... Cloud Formation is still working at creating all the components via CloudFormation.
To view the CloudFormation task in progress, go to AWS CloudFormation and find the "apigateway-standalone-ecs" stack.

## Destroy the environment

Simply run:

```
docker compose down
```

NOTE: if you specifically created the following AWS resources for this, you should delte them manually as needed:
 - x-aws-vpc: ${TARGET_VPC}
 - x-aws-loadbalancer: ${TARGET_LOADBALANCER}
 - x-aws-cluster: ${TARGET_ECS_CLUSTER}

## Advanced setup - Modify the generated Cloudformation Template

We understand that every cloud environment are different, and that the generated AWS CloudFormation template from the "docker compose" bridge may not be appropriate in all situations. That is why and when you may want to simply generate the "AWS CloudFormation" as a staring point, and then modify it based on your own requirements.

To generate the AWS CloudFormation template at [./cloudformation/docker-compose-cloudformation-generated.yaml](./cloudformation/docker-compose-cloudformation-generated.yaml), run:

```
docker compose convert > ./cloudformation/docker-compose-cloudformation-generated.yaml
```

From there, you can edit and modify anything you want. For the purpose of this tutorial, we'll consider the final (modified) CloudFormation template at: 
[./cloudformation/apigateway-standalone-ecs-cloudformation.yaml](./cloudformation/apigateway-standalone-ecs-cloudformation.yaml)

Finally, deploy the AWS CloudFormation template directly to AWS like you would any other CloudFormation template.
Here we'll be using the AWS CLI to deploy it, using the following command:

```
aws cloudformation deploy --template ./cloudformation/apigateway-standalone-ecs-cloudformation.yaml --stack-name apigateway-standalone-ecs --capabilities CAPABILITY_IAM
```

### Advanced setup use case 1 - Add a single-run job task

#### Problem statement

In order to configure various aspect of the APIGateway, we have created a "configurator" image that should be deployed as a "run-once" job (ie. it runs, configure things, and terminates)
But by strcitly using the Docker-compose mechanism to deploy, it creates a "ECS Container Service" in AWS ECS for the configurator...which is not the desired deployment type we need here.
AWS ECS will try and restart any services whenever they are detected as down...which has the undesired effect to restart and re-run the configurator job continuously in this case.
So we need a way to just create an ECS Task for the configurator...as opposed to a ECS Service.



To generate the AWS CloudFormation template for the configurator, run:

```
docker compose convert > ./cloudformation/docker-compose-configurator-cloudformation-generated.yaml
```

Then modify it to remove all the "service semantics", essentially keeping the "AWS::ECS::TaskDefinition" and "AWS::IAM::Role" for the task...
See the final AWS CF template for this at [./cloudformation/apigateway-standalone-ecs-configurator-cloudformation.yaml](./cloudformation/apigateway-standalone-ecs-configurator-cloudformation.yaml)

Finally, deploy:

```
aws cloudformation deploy --template ./cloudformation/apigateway-standalone-ecs-configurator-cloudformation.yaml --stack-name apigateway-standalone-ecs-configurator --capabilities CAPABILITY_IAM
```

Once the task definition is deployed, all we need is to create a new task for it. To launch this single run-once task, we'll need to use the AWS ECS CLI for it (cloud formation does not have a single task reference)

Get the ARN for the Task Definition:

```
TASKDEF=$(aws cloudformation describe-stacks --stack-name apigateway-standalone-ecs-configurator --query 'Stacks[*].Outputs[?OutputKey==`ApigatewayConfiguratorTaskDef`]' --output text | awk '{print $NF}')
echo $TASKDEF
```

Then, create a task for it:

```
aws ecs run-task --cli-input-yaml file://run-task-configurator.yaml --task-definition $TASKDEF
```