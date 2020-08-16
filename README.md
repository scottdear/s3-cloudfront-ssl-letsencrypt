# s3-cloudfront-ssl-letsencrypt
Provision a static website using s3 cloudfront and SSL certs provisioned by Let's Encrypt with Auto-renew

This project contains the Cloudformation yml files and deployment scripts necessary to use the [ acme-dns-route53 Lambda](https://github.com/begmaroman/acme-dns-route53/blob/master/LAMBDA.md) in a multi-tenant environment with switching for production, development and QA deployment.

##Features

* Uses Cloudformation for easy deployment of multiple stacks
* Adds [ support to acme-dns-route53 for s3 storage ](https://github.com/scottdear/acme-dns-route53) of certs in private buckets
* Support for cloudwatch triggers
* Easy integration w/ CI/CD tools like Jenkins

## Requirements
* bash
* GoLang 1.12+
* Modified Fork of acme-dns-route53 [github.com/scottdear/acme-dns-route53](https://github.com/scottdear/acme-dns-route53)

## Installation


### Inspired by:
* Sov Tech Insights - [ Creating a CloudFormation script to host a static site](https://medium.com/sovtech-insights/creating-a-cloudformation-script-to-host-a-static-site-on-s3-cloudfront-ssl-f9781c30e93c)
* Roman Behma - [acme-dns-route53](https://github.com/begmaroman/acme-dns-route53)
* Aric The Bearded - [My son's Dungeon Master for Hire site](https://www.aricthebearded.com) he let me use as a guinea pig.
