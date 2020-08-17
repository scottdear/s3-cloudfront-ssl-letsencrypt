#!/bin/sh
# deploy_s3.sh - This creates the private S3 bucket to store certs and the different versions of
# the cert-update Function acme-dns-route53.  This only needs to be run  once to initialize the bucket.

#Replace these w/ Environemt Variables in your CI/CD system(s)
ENVIRONMENT="dev"
CUSTOMER="atb"
APP="web"
MODULE="ssl"
COMPONENT="s3"
REGION="us-east-1"

STACK_NAME="${CUSTOMER}-${APP}-${MODULE}-${COMPONENT}-${ENVIRONMENT}"
PRIVATE_BUCKET="${CUSTOMER}-${APP}-${MODULE}-private-${ENVIRONMENT}"

aws cloudformation deploy --stack-name $STACK_NAME --region $REGION --capabilities CAPABILITY_NAMED_IAM \
	--template-file  "${COMPONENT}_template.yml" --no-fail-on-empty-changeset \
	--tags \
	    application=$APP \
	    customer=$CUSTOMER \
	    environment=$ENVIRONMENT \
	--parameter-overrides \
	    EnvironmentName=$ENVIRONMENT \
	    PrivateBucket=$PRIVATE_BUCKET
