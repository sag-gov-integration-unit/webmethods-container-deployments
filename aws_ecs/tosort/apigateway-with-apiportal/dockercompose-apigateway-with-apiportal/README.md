# Using Docker-compose to deploy webmethods API Management in AWS Elastic Container Server (ECS)

For more details about Docker and AWS ECS integration, read https://docs.docker.com/cloud/ecs-integration/

*Important* 
This docker-compose example is more of a quick start to test the webmethods API Management for yourself on AWS ECS, than a real production-ready deployment type!!

## Pre-requisites

1) Make sure you followed the [instructions](../../README.md) to build and push the various SoftwareAG images to your AWS ECR registry.
2) Make sure you have Docker Desktop and Docker-Compose installed on your workstation.

## Step 1: Create or Use Docker AWS ECS context

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

## Step 2a - Pre-create AWS Components

Because cloud operators / architects generally want extra control on the AWS items created, we have structured our docker-compose deployment file to expect the following 3 items to be externally created:

 - AWS VPC (to host the ECS cluster) 
 - AWS ECS cluster (to create the type of ECS cluster you want)
 - AWS Network Load balancer (to route the traffic to the ECS cluster) 

So in the docker-compose, AWS allows you to specify the IDs/Shortnames for the external pre-created items by setting up few variables at the top of the docker-compose file:
 - x-aws-vpc: ${TARGET_VPC}
 - x-aws-cluster: ${TARGET_ECS_CLUSTER}
 - x-aws-loadbalancer: ${TARGET_LOADBALANCER}

If you chose to follow that route, pre-create these 3 components, and specify the IDs in env variables so our docker-compose deployment can use them: 

```
export TARGET_VPC=vpc-************
export TARGET_ECS_CLUSTER=myecstests
export TARGET_LOADBALANCER=ecs-tests-alb
```

NOTEs: 
In our own testing environment we chose to pre-create these 3 components to control their creation in more details.
Also, docker-compose may also not have the capability to create these the expected way.

## Step 2b - Let the deployment create some or all the AWS external items

If you want the docker-compose deployment to create all new AWS VPC, AWS ECS, and AWS Load balancer, simply *remove* the desired lines from the docker-compose
 - x-aws-vpc: ${TARGET_VPC}
 - x-aws-cluster: ${TARGET_ECS_CLUSTER}
 - x-aws-loadbalancer: ${TARGET_LOADBALANCER}

NOTEs: This may not work, depending on your AWS environment and capabilities. In which case, go back to 2a)

## Step 3 - Load the deployment into ECS using compose

Again, make sure you're in the right ECS context...if not go back to Step 1.

```
docker context list

> myecscontext *      ecs
```

Then, deploy the stack to AWS ECS by running:

```
docker compose --env-file ../../configs/docker.env${SAG_RELEASE} up -d
```

## Verifications

It's important to understand that the "docker compose" command really creates behind the scene a "AWS CloudFormation" template (AWS automation template), uploads it to AWS, and launches it.

What this means is that at the end of the "docker compose" command above, the environment is not yet fully created... Cloud Formation is still working at creating all the components via CloudFormation.
To view the CloudFormation task in progress, go to AWS CloudFormation and find the "dockercompose-apigateway-with-apiportal" stack.

If all went well, you should see a status of "CREATE_COMPLETE" on the "dockercompose-apigateway-with-apiportal" stack. 

And also, if you go to the AWS ALB that you had pre-created before, you should now see 3 new listeners entries, 1 for each of the ports exposed:
 - 9072
 - 5555
 - 18101

Finally, you should be able to access the UIs at the following URLs:
 - API gateway: http://<AWS ALB DNS>:9072/apigatewayui
 - API portal: http://<AWS ALB DNS>:18101

## Generated Cloudformation template

To generate and view the AWS CloudFormation template that gets generated from the docker-compose command, run:

```
docker compose --env-file ../../configs/docker.env${SAG_RELEASE} convert > ./cloudformation/cloudformation-generated.yaml
```

For your convenience, we saved it here at [./cloudformation/docker-compose-cloudformation-generated.yaml](./cloudformation/docker-compose-cloudformation-generated.yaml)

## Destroy the environment

Simply run:

```
docker compose --env-file ../../configs/docker.env${SAG_RELEASE} down
```

NOTE: if you specifically created the following AWS resources for this, you should delte them manually as needed:
 - x-aws-vpc: ${TARGET_VPC}
 - x-aws-loadbalancer: ${TARGET_LOADBALANCER}
 - x-aws-cluster: ${TARGET_ECS_CLUSTER}
