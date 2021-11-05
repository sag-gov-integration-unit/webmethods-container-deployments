# Using Cloudformation to deploy webmethods API Management in AWS Elastic Container Server (ECS)

In this sample we'll be using Cloudformation from the start to create the full SoftwareAG APIManagement stack on AWS ECS.

## TO CLEANUP
## TO CLEANUP
## TO CLEANUP
## TO CLEANUP

## Pre-requisites

1) Make sure you followed the [instructions](../../README.md) to build and push the various SoftwareAG images to your AWS ECR registry.

## Step 1 - Pre-create AWS Components

Because cloud operators / architects generally want extra control on the AWS items created, we have structured our docker-compose deployment file to expect the following 3 items to be externally created:

 - AWS VPC (to host the ECS cluster) 
 - AWS ECS cluster (to create the type of ECS cluster you want)
 - AWS Load balancer (to route the traffic to the ECS cluster) 

## Step 2 - Load the deployment into AWS ECS using AWS Cloudformation

We have pre-created an AWS CloudFormation template at [./apigateway-with-apiportal.yaml](./apigateway-with-apiportal.yaml)

Simply deploy the AWS CloudFormation template directly to AWS like you would any other CloudFormation template.

```
aws cloudformation deploy --template ./apigateway-with-apiportal.yaml --stack-name apigateway-with-apiportal-ecs --capabilities CAPABILITY_IAM
```



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

## Add a single-run job task

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