# Base AWS ECS Infrastructure for ECS Tutorials

Depending on the region you're in, you'll likely have the right region already set in your AWS CLI...
but in case, you can simply set the right region here with the following variable:

```bash
export AWS_REGION=us-east-1
```

## Deploy

```bash
aws cloudformation deploy --template ./main.yaml --stack-name webmethods-samples-aws
```

## Destroy

```bash
aws cloudformation delete-stack --stack-name webmethods-samples-aws
```