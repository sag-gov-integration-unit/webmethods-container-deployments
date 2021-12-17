# webmethods API Management in AWS Elastic Container Server (ECS) by Software AG Government Solutions 

This is a group of sample deployments for AWS Elastic Container Server (ECS) by Software AG Government Solutions.

## Pre-requisites 3

You should already have all the API Management images (with lcienses) already uplaoded to your AWS ECR registry.
If not, refer to [webmethods API Management in your Private Registry by Software AG Government Solutions ](../../private_registries/api_management/README.md)

## Deployments

```bash
export AWS_REGION=us-east-1
```

Validate:

aws cloudformation validate-template --template-body file://cloudformation-apimgt-stack.yaml

Deploy:

```bash
VPCID=$(aws cloudformation describe-stacks --stack-name webmethods-samples-aws --query "Stacks[0].Outputs[?OutputKey=='VPCID'].OutputValue" --output text)
ECSCluster=$(aws cloudformation describe-stacks --stack-name webmethods-samples-aws --query "Stacks[0].Outputs[?OutputKey=='ECSArn'].OutputValue" --output text)
SubnetIDs=$(aws cloudformation describe-stacks --stack-name webmethods-samples-aws --query "Stacks[0].Outputs[?OutputKey=='AppSubnets'].OutputValue" --output text)
LoadBalancerArn=$(aws cloudformation describe-stacks --stack-name webmethods-samples-aws --query "Stacks[0].Outputs[?OutputKey=='AppLoadBalancerArn'].OutputValue" --output text)

echo "Parameters: $VPCID, $ECSCluster, $SubnetIDs, $LoadBalancerArn"

aws cloudformation deploy --template ./cloudformation-apimgt-stack.yaml --stack-name cloudformation-apimgt-stack-ecs --parameter-overrides $(cat configs/params_1011.properties | tr "\n" " ") VPCID=$VPCID ECSCluster=$ECSCluster SubnetIDs=$SubnetIDs LoadBalancerArn=$LoadBalancerArn --no-execute-changeset --capabilities CAPABILITY_IAM


aws cloudformation deploy --template ./cloudformation-apimgt-stack.yaml --stack-name cloudformation-apimgt-stack-ecs --parameter-overrides $(printf "\n" | cat configs/params_1011.properties - configs/env.properties | tr "\n" " ") --no-execute-changeset --capabilities CAPABILITY_IAM
```

### Stack Apigateway With Apiportal

Pick the deployment type you want to try...with more detailed instructions:

- [dockercompose-to-ecs](./apigateway-with-apiportal/dockercompose-apigateway-with-apiportal/README.md)
- [cloudformation-to-ecs](./apigateway-with-apiportal/cloudformation/README.md)
