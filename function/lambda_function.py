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

import boto3

from crhelper import CfnResource

helper = CfnResource()
ec2_client = boto3.client('ec2')

@helper.create
@helper.update
def get_pl(event, _):
    response = ec2_client.describe_prefix_lists(
            Filters=[
                {
                    'Name': 'prefix-list-name',
                    'Values': [
                        event['ResourceProperties']['plname']
                    ]
                }
            ]
    )

    helper.Data['result'] = response['PrefixLists'][0]['PrefixListId']

@helper.delete
def no_op(_, __):
    pass

def handler(event, context):
    helper(event, context)
