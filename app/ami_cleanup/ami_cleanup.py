import boto3
import os
import sys

# Add the app/utils directory to the path to import logger_utils
sys.path.insert(0, os.path.join(os.path.dirname(__file__), '..', 'utils'))
from logger_utils import get_logger


def lambda_handler(event, context):
    logger = get_logger("ami_cleanup")
    
    ec2_client = boto3.client('ec2')
    tag_key = os.environ.get('TAG_KEY', 'Project')
    tag_value = os.environ.get('TAG_VALUE', 'StreamlinedImageCreation')
    keep_latest = int(os.environ.get('KEEP_LATEST', '1'))

    # Get all AMIs with the specified tag
    response = ec2_client.describe_images(
        Filters=[
            {
                'Name': f'tag:{tag_key}',
                'Values': [tag_value]
            }
        ],
        Owners=['self']
    )

    # Sort AMIs by creation date
    amis = sorted(
        response['Images'],
        key=lambda x: x['CreationDate'],
        reverse=True
    )
    logger.info(f"Found {len(amis)} AMIs with tag {tag_key}={tag_value}")

    # Keep the latest N AMIs, deregister the rest
    for ami in amis[keep_latest:]:
        ami_id = ami['ImageId']
        creation_date = ami['CreationDate']
        logger.info(f"Deregistering AMI {ami_id} created on {creation_date}")
        ec2_client.deregister_image(ImageId=ami_id)

        # Delete associated snapshots
        for device in ami.get('BlockDeviceMappings', []):
            if 'Ebs' in device and 'SnapshotId' in device['Ebs']:
                snapshot_id = device['Ebs']['SnapshotId']
                logger.info(
                    f"Deleting snapshot {snapshot_id} for AMI {ami_id}"
                )
                ec2_client.delete_snapshot(SnapshotId=snapshot_id)

    return {
        'statusCode': 200,
        'body': (
            f"Cleanup complete. Kept latest {keep_latest} AMI(s), "
            f"deregistered {len(amis) - keep_latest} AMI(s)."
        )
    }
