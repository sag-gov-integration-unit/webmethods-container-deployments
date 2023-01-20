#!/bin/bash

# This file will build the SoftwareAG images with your own license file

BASE_INFRA_STACK_NAME="webmethods-samples-aws"
DEPLOY_STACK_NAME="cloudformation-apimgt-stack-ecs"
ECR_REPO="$1"

#check for errors
if [ "x$SAG_RELEASE" == "x" ]; then
    echo "Env var SAG_RELEASE is empty. Provide a valid SAG_RELEASE value (107,1011). ie. 'export SAG_RELEASE=1011'"
    exit 2;
fi

if [ "x$ECR_REPO" == "x" ]; then
    echo "Usage: /bin/sh deploy.sh <ECR_REPO>"
    echo "ECR_REPO missing: please provide a valid parameter for the ECR_REPO Registry where the SoftwareAG images are available"
    exit 2;
fi

echo "#################################################################"
echo "Deploying APIManagement stack for SAG_RELEASE=$SAG_RELEASE"
echo "#################################################################"

# get values from the base stack
VPCID=$(aws cloudformation describe-stacks --stack-name $BASE_INFRA_STACK_NAME --query "Stacks[0].Outputs[?OutputKey=='VPCID'].OutputValue" --output text)
ECSCluster=$(aws cloudformation describe-stacks --stack-name $BASE_INFRA_STACK_NAME --query "Stacks[0].Outputs[?OutputKey=='ECSArn'].OutputValue" --output text)
SubnetIDs=$(aws cloudformation describe-stacks --stack-name $BASE_INFRA_STACK_NAME --query "Stacks[0].Outputs[?OutputKey=='AppSubnets'].OutputValue" --output text)
LoadBalancerArn=$(aws cloudformation describe-stacks --stack-name $BASE_INFRA_STACK_NAME --query "Stacks[0].Outputs[?OutputKey=='AppLoadBalancerArn'].OutputValue" --output text)
LoadBalancerDNS=$(aws cloudformation describe-stacks --stack-name $BASE_INFRA_STACK_NAME --query "Stacks[0].Outputs[?OutputKey=='AppLoadBalancerDns'].OutputValue" --output text)
ECRName="$ECR_REPO"

echo "Parameters: VPCID=$VPCID, ECSCluster=$ECSCluster, SubnetIDs=$SubnetIDs, LoadBalancerArn=$LoadBalancerArn, LoadBalancerDNS=$LoadBalancerDNS, ECRName=$ECRName"

aws cloudformation deploy \
    --template ./cloudformation-apimgt-stack.yaml \
    --stack-name ${DEPLOY_STACK_NAME} \
    --parameter-overrides $(cat configs/params_${SAG_RELEASE}.properties | tr "\n" " ") VPCID=$VPCID ECSCluster=$ECSCluster SubnetIDs=$SubnetIDs LoadBalancerArn=$LoadBalancerArn LoadBalancerDNS=$LoadBalancerDNS ECRName=$ECRName \
    --capabilities CAPABILITY_IAM

echo "#################################################################"
echo "All DONE!!!!"
echo "Product UIs will be available at:"
echo " - MSR Admin URL: http://$LoadBalancerDNS:5555"
echo "#################################################################"