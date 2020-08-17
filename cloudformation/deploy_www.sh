#!/bin/sh
# deploy_www.sh - This creates a public S3 bucket for hosting static files on the internet, and connects
#                 A cloudfront bucket to the S3 bucket so a subsequent SSL certificate can be attached.

# Replace these variables w/ environment variables from your CI/CD
ENVIRONMENT="dev"
CUSTOMER="<YOUR_ID>"
APP="web"
MODULE="content"
COMPONENT="www"
REGION="us-east-1"
DOMAIN="<yourdomain.com>" # TOP LEVEL DOMAIN
DOMAIN_NAME="www.${DOMAIN}" #  FQDN
HOSTED_ZONE_ID="<YOUR_HOSTED_ZONE_ID>" # The zone ID of your previously configured zone in route53

STACK_NAME="${CUSTOMER}-${APP}-${MODULE}-${COMPONENT}-${ENVIRONMENT}"
PUBLIC_CONTENT_BUCKET="${CUSTOMER}-${APP}-${MODULE}-public-${ENVIRONMENT}"
PRIVATE_BUCKET="${CUSTOMER}-${APP}-${MODULE}-private-${ENVIRONMENT}"

aws cloudformation deploy --stack-name $STACK_NAME --region $REGION --capabilities CAPABILITY_NAMED_IAM \
	--template-file  "${COMPONENT}_template.yml" --no-fail-on-empty-changeset \
	--tags \
	    application=$APP \
	    customer=$CUSTOMER \
	    environment=$ENVIRONMENT \
	--parameter-overrides \
	    EnvironmentName=$ENVIRONMENT \
	    PublicBucket=$PUBLIC_CONTENT_BUCKET \
	    PrivateBucket=$PRIVATE_BUCKET \
	    DomainName=$DOMAIN_NAME \
	    HostedZoneID=$HOSTED_ZONE_ID \
	    Domain=$DOMAIN \
