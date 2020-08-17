#!/bin/sh
# This deploys the IAM roles needed to run the acme-dns-route53 lambda
# The Deployment bits called by by your continuous delivery application, e.g. Ansible, Octopus, Jenkins etc.
# Cut paste/glue/hack/gouge - you know the drill
# This  Role is used by  the acme-dns-route53 Go Serverless Function deploy in cert-update.sh
# Dependencies: Must have created a private S3 bucket with deploy_s3.sh

#Replace these w/ Environemt Variables in your CI/CD system(s)
ENVIRONMENT="dev"
AWS_ACCOUNT_ID="<YOUR_AWS_ACCOUNT_ID>"
CUSTOMER="atb"
APP="web"
MODULE="ssl"
COMPONENT="cert-iam"
REGION="us-east-1"
HOSTED_ZONE_ID="<YOUR_HOSTED_ZONE>"

STACK_NAME="${CUSTOMER}-${APP}-${MODULE}-${COMPONENT}-${ENVIRONMENT}"
PRIVATE_BUCKET="${CUSTOMER}-${APP}-${MODULE}-private-${ENVIRONMENT}"
CERT_LAMBDA_ROLE="${CUSTOMER}-${APP}-${MODULE}-${COMPONENT}-${ENVIRONMENT}-role"

aws cloudformation deploy --stack-name $STACK_NAME --region $REGION --capabilities CAPABILITY_NAMED_IAM \
	--template-file  "${COMPONENT}_template.yml" --no-fail-on-empty-changeset \
	--tags \
	    application=$APP \
	    customer=$CUSTOMER \
	    environment=$ENVIRONMENT \
	--parameter-overrides \
	    Region=$REGION \
	    EnvironmentName=$ENVIRONMENT \
	    AWSAccount=$AWS_ACCOUNT_ID \
	    PrivateBucket=$PRIVATE_BUCKET \
	    HostedZoneID=$HOSTED_ZONE_ID \
	    CertLambdaRoleName=$CERT_LAMBDA_ROLE
