import json
import boto3
import os


def test_s3(event, context):

    client = boto3.client('s3')
    response = client.get_bucket_acl(Bucket=os.environ['bucket_name'])
    return json.dumps(response)

def test_ssm(event, context):

    client = boto3.client('ssm')
    response = client.get_parameter(
    Name=os.environ['parameter_name'],
    WithDecryption=False
    )
    return json.dumps(response['Parameter']['Value'])