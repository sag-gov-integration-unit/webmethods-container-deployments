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

Refer to [Common AWS ECS Infrastructure Cloudformation Template](../base_ecs_infra/README.md) to run...

## Deploy the API Management container stack into ECS (using cloudformation)

First, export the values needed like the AWS REGION and the AWS Registry (ECR) that contains the SAG images:
```bash
export AWS_REGION=us-east-1
export AWS_ECR=<ECR>.amazonaws.com
```

Then, Deploy:

```bash
VPCID=$(aws cloudformation describe-stacks --stack-name webmethods-samples-aws --query "Stacks[0].Outputs[?OutputKey=='VPCID'].OutputValue" --output text)
ECSCluster=$(aws cloudformation describe-stacks --stack-name webmethods-samples-aws --query "Stacks[0].Outputs[?OutputKey=='ECSArn'].OutputValue" --output text)
SubnetIDs=$(aws cloudformation describe-stacks --stack-name webmethods-samples-aws --query "Stacks[0].Outputs[?OutputKey=='AppSubnets'].OutputValue" --output text)
LoadBalancerArn=$(aws cloudformation describe-stacks --stack-name webmethods-samples-aws --query "Stacks[0].Outputs[?OutputKey=='AppLoadBalancerArn'].OutputValue" --output text)
LoadBalancerDNS=$(aws cloudformation describe-stacks --stack-name webmethods-samples-aws --query "Stacks[0].Outputs[?OutputKey=='AppLoadBalancerDns'].OutputValue" --output text)
ECRName=$AWS_ECR

echo "Parameters: VPCID=$VPCID, ECSCluster=$ECSCluster, SubnetIDs=$SubnetIDs, LoadBalancerArn=$LoadBalancerArn, LoadBalancerDNS=$LoadBalancerDNS, ECRName=$ECRName"

aws cloudformation deploy --template ./cloudformation-apimgt-stack.yaml --stack-name cloudformation-apimgt-stack-ecs --parameter-overrides $(cat configs/params_1011.properties | tr "\n" " ") VPCID=$VPCID ECSCluster=$ECSCluster SubnetIDs=$SubnetIDs LoadBalancerArn=$LoadBalancerArn LoadBalancerDNS=$LoadBalancerDNS ECRName=$ECRName --capabilities CAPABILITY_IAM
```

## Run One-Time-Use DevPortal Configurator Task

Get the needed values for the previous deployed ECS Cloudformation stack:

```bash
VPCID=$(aws cloudformation describe-stacks --stack-name cloudformation-apimgt-stack-ecs --query "Stacks[0].Outputs[?OutputKey=='VPCID'].OutputValue" --output text)
ECSCluster=$(aws cloudformation describe-stacks --stack-name cloudformation-apimgt-stack-ecs --query "Stacks[0].Outputs[?OutputKey=='ECSCluster'].OutputValue" --output text)
SubnetIDs=$(aws cloudformation describe-stacks --stack-name cloudformation-apimgt-stack-ecs --query "Stacks[0].Outputs[?OutputKey=='SubnetIDs'].OutputValue" --output text)
SecurityGroupId=$(aws cloudformation describe-stacks --stack-name cloudformation-apimgt-stack-ecs --query "Stacks[0].Outputs[?OutputKey=='SecurityGroupId'].OutputValue" --output text)
PortalConfiguratorTaskDef=$(aws cloudformation describe-stacks --stack-name cloudformation-apimgt-stack-ecs --query "Stacks[0].Outputs[?OutputKey=='PortalConfiguratorTaskDef'].OutputValue" --output text)

echo "Parameters: VPCID=$VPCID, ECSCluster=$ECSCluster, SubnetIDs=$SubnetIDs, SecurityGroupId=$SecurityGroupId, PortalConfiguratorTaskDef=$PortalConfiguratorTaskDef"
```

Then, create a new task for the configurator:

```bash
aws ecs run-task \
    --count 1 \
    --task-definition $PortalConfiguratorTaskDef \
    --cluster $ECSCluster \
    --group cloudformation-apimgt-stack-ecs \
    --launch-type FARGATE \
    --platform-version 1.4.0 \
    --propagate-tags TASK_DEFINITION \
    --enable-ecs-managed-tags \
    --network-configuration "awsvpcConfiguration={subnets=[$SubnetIDs],securityGroups=[$SecurityGroupId],assignPublicIp=DISABLED}"
```

## Run One-Time-Use APIGateway Configurator Task

Get the needed values for the previous deployed ECS Cloudformation stack:

```bash
VPCID=$(aws cloudformation describe-stacks --stack-name cloudformation-apimgt-stack-ecs --query "Stacks[0].Outputs[?OutputKey=='VPCID'].OutputValue" --output text)
ECSCluster=$(aws cloudformation describe-stacks --stack-name cloudformation-apimgt-stack-ecs --query "Stacks[0].Outputs[?OutputKey=='ECSCluster'].OutputValue" --output text)
SubnetIDs=$(aws cloudformation describe-stacks --stack-name cloudformation-apimgt-stack-ecs --query "Stacks[0].Outputs[?OutputKey=='SubnetIDs'].OutputValue" --output text)
SecurityGroupId=$(aws cloudformation describe-stacks --stack-name cloudformation-apimgt-stack-ecs --query "Stacks[0].Outputs[?OutputKey=='SecurityGroupId'].OutputValue" --output text)
ApiGatewayConfiguratorTaskDef=$(aws cloudformation describe-stacks --stack-name cloudformation-apimgt-stack-ecs --query "Stacks[0].Outputs[?OutputKey=='ApigatewayConfiguratorTaskDef'].OutputValue" --output text)

echo "Parameters: VPCID=$VPCID, ECSCluster=$ECSCluster, SubnetIDs=$SubnetIDs, SecurityGroupId=$SecurityGroupId, ApiGatewayConfiguratorTaskDef=$ApiGatewayConfiguratorTaskDef"
```

Then, create a new task for the configurator:

```bash
aws ecs run-task \
    --count 1 \
    --task-definition $ApiGatewayConfiguratorTaskDef \
    --cluster $ECSCluster \
    --group cloudformation-apimgt-stack-ecs \
    --launch-type FARGATE \
    --platform-version 1.4.0 \
    --propagate-tags TASK_DEFINITION \
    --enable-ecs-managed-tags \
    --network-configuration "awsvpcConfiguration={subnets=[$SubnetIDs],securityGroups=[$SecurityGroupId],assignPublicIp=DISABLED}"
```

## Delete stack

```bash
aws cloudformation delete-stack --stack-name cloudformation-apimgt-stack-ecs
```