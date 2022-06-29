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

ClientEC2Stack=$( aws cloudformation list-stacks --output json | jq '.StackSummaries[] | select((.StackStatus=="CREATE_COMPLETE") or (.StackStatus=="UPDATE_COMPLETE")) | select (.StackName | contains ("dicoogle-ClientEC2Stack"))' | jq -r '.StackName' )
ImagesBucketStack=$( aws cloudformation list-stacks --output json | jq '.StackSummaries[] | select((.StackStatus=="CREATE_COMPLETE") or (.StackStatus=="UPDATE_COMPLETE")) | select (.StackName | contains ("dicoogle-ImagesBucketStack"))' | jq -r '.StackName' )
DataSyncStack=$( aws cloudformation list-stacks --output json | jq '.StackSummaries[] | select((.StackStatus=="CREATE_COMPLETE") or (.StackStatus=="UPDATE_COMPLETE")) | select (.StackName | contains ("dicoogle-DataSyncStack"))' | jq -r '.StackName' )
CognitoStack=$( aws cloudformation list-stacks --output json | jq '.StackSummaries[] | select((.StackStatus=="CREATE_COMPLETE") or (.StackStatus=="UPDATE_COMPLETE")) | select (.StackName | contains ("dicoogle-CognitoStack"))' | jq -r '.StackName' )
ECSStack=$( aws cloudformation list-stacks --output json | jq '.StackSummaries[] | select((.StackStatus=="CREATE_COMPLETE") or (.StackStatus=="UPDATE_COMPLETE")) | select (.StackName | contains ("dicoogle-ECSStack"))' | jq -r '.StackName' )
StorageEC2Stack=$( aws cloudformation list-stacks --output json | jq '.StackSummaries[] | select((.StackStatus=="CREATE_COMPLETE") or (.StackStatus=="UPDATE_COMPLETE")) | select (.StackName | contains ("dicoogle-StorageEC2Stack"))' | jq -r '.StackName' )
PrivatelinkStack=$( aws cloudformation list-stacks --output json | jq '.StackSummaries[] | select((.StackStatus=="CREATE_COMPLETE") or (.StackStatus=="UPDATE_COMPLETE")) | select (.StackName | contains ("dicoogle-PrivatelinkStack"))' | jq -r '.StackName' )
LogBucketStack=$( aws cloudformation list-stacks --output json | jq '.StackSummaries[] | select((.StackStatus=="CREATE_COMPLETE") or (.StackStatus=="UPDATE_COMPLETE")) | select (.StackName | contains ("dicoogle-LogBucketStack"))' | jq -r '.StackName' )

CognitoStack_UserPool=$( aws cloudformation describe-stacks --stack-name $CognitoStack --output json | jq -r '.Stacks[].Outputs[] | select (.OutputKey=="UserPool")' | jq -r .OutputValue )
ECSStack_ALBDnsRecord=$( aws cloudformation describe-stacks --stack-name $ECSStack --output json | jq -r '.Stacks[].Outputs[] | select (.OutputKey=="ALBDnsRecord")' | jq -r .OutputValue )
export ClientEC2Stack_PublicDNS=$( aws cloudformation describe-stacks --stack-name $ClientEC2Stack --output json | jq -r '.Stacks[].Outputs[] | select (.OutputKey=="InstancePublicDNS")' | jq -r .OutputValue )
export StorageEC2Stack_PublicDNS=$( aws cloudformation describe-stacks --stack-name $StorageEC2Stack --output json | jq -r '.Stacks[].Outputs[] | select (.OutputKey=="InstancePublicDNS")' | jq -r .OutputValue )
export DataSyncStack_TaskArn=$( aws cloudformation describe-stacks --stack-name $DataSyncStack --output json | jq -r '.Stacks[].Outputs[] | select (.OutputKey=="S3ToEfsTaskArn")' | jq -r .OutputValue )
export PrivatelinkStack_ProviderEndpoint=$( aws cloudformation describe-stacks --stack-name $PrivatelinkStack --output json | jq -r '.Stacks[].Outputs[] | select (.OutputKey=="ProviderEndpoint")' | jq -r .OutputValue )
export LogBucketStack_LogBucket=$( aws cloudformation describe-stacks --stack-name $LogBucketStack --output json | jq -r '.Stacks[].Outputs[] | select (.OutputKey=="LogBucket")' | jq -r .OutputValue )
export ImagesBucketStack_ImagesBucket=$( aws cloudformation describe-stacks --stack-name $ImagesBucketStack --output json | jq -r '.Stacks[].Outputs[] | select (.OutputKey=="ImagesBucket")' | jq -r .OutputValue )

echo "ClientEC2 PublicDNS: $ClientEC2Stack_PublicDNS"
echo "ImagesBucket: $ImagesBucketStack_ImagesBucket"
echo "DataSync TaskArn: $DataSyncStack_TaskArn"
echo "Cognito UserPool: $CognitoStack_UserPool"
echo "ALBDnsRecord: $ECSStack_ALBDnsRecord"
echo "StorageEC2 PublicDNS: $StorageEC2Stack_PublicDNS"
echo "ProviderEndpoint: $PrivatelinkStack_ProviderEndpoint"
echo "LogBucket: $LogBucketStack_LogBucket"
