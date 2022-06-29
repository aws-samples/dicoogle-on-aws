# Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
#
# Permission is hereby granted, free of charge, to any person obtaining a copy of
# this software and associated documentation files (the "Software"), to deal in
# the Software without restriction, including without limitation the rights to
# use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
# the Software, and to permit persons to whom the Software is furnished to do so.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
# FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
# COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
# IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
# CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

#!/bin/bash

set -e

if [ "$#" -ne 1 ]; then
    echo "This script requires a S3 bucket name to be supplied as argument"
    echo -e "\nUsage: $0 <S3 bucket to hold deployment artifacts> \n"
    exit 1
fi

export REGION=$( curl -s http://169.254.169.254/latest/meta-data/placement/availability-zone |  sed 's/\(.*\)[a-z]/\1/' )

(cd function; pip install crhelper -t .)

(aws cloudformation package --template-file template/dicoogle-lambda-template.yaml --s3-bucket $1 --output-template-file build/dicoogle-lambda-deployment.yaml)

aws s3 cp template/dicoogle-main-template.yaml s3://$1/
aws s3 cp build/dicoogle-lambda-deployment.yaml s3://$1/
aws s3 cp template/dicoogle-vpc-template.yaml s3://$1/
aws s3 cp template/dicoogle-dns-template.yaml s3://$1/
aws s3 cp template/dicoogle-kms-template.yaml s3://$1/
aws s3 cp template/dicoogle-logbucket-template.yaml s3://$1/
aws s3 cp template/dicoogle-imagesbucket-template.yaml s3://$1/
aws s3 cp template/dicoogle-efs-template.yaml s3://$1/
aws s3 cp template/dicoogle-datasync-template.yaml s3://$1/
aws s3 cp template/dicoogle-ec2-template.yaml s3://$1/
aws s3 cp template/dicoogle-ecs-template.yaml s3://$1/
aws s3 cp template/dicoogle-privatelink-template.yaml s3://$1/
aws s3 cp template/dicoogle-cognito-template.yaml s3://$1/
aws s3 cp template/dicoogle-vpcpeering-template.yaml s3://$1/

echo "S3 template URL: https://$1.s3.$REGION.amazonaws.com/dicoogle-main-template.yaml"
