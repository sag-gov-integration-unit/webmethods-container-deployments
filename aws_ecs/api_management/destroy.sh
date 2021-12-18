#!/bin/bash

aws cloudformation delete-stack --stack-name cloudformation-apimgt-stack-ecs

echo "Done!"