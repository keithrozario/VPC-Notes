# resource "aws_s3_bucket" "S3vpcFlowLog" {
#     bucket_prefix = "flowlog"
#     force_destroy = true
# }
# resource "aws_flow_log" "vpcFlowLogS3" {
#   log_destination      = "${aws_s3_bucket.S3vpcFlowLog.arn}"
#   log_destination_type = "s3"
#   traffic_type         = "ALL"
#   vpc_id               = "${aws_vpc.main.id}"
# }

# resource "aws_iam_role" "flowLogRoleS3" {
#   name = "flowLogRoleS3"

#   assume_role_policy = <<EOF
# {
#   "Version": "2012-10-17",
#   "Statement": [
#     {
#       "Sid": "",
#       "Effect": "Allow",
#       "Principal": {
#         "Service": "vpc-flow-logs.amazonaws.com"
#       },
#       "Action": "sts:AssumeRole"
#     }
#   ]
# }
# EOF
# }

# resource "aws_iam_role_policy" "s3flowLogRolePolicy" {
#   name = "flowLogRolePolicy"
#   role = "${aws_iam_role.flowLogRoleS3.id}"

#   policy = <<EOF
# {
#   "Version": "2012-10-17",
#   "Statement": [
#     {
#       "Action": [
#         "s3:PutObject"
#       ],
#       "Effect": "Allow",
#       "Resource": "${aws_s3_bucket.S3vpcFlowLog.arn}/*"
#     },
#     {
#       "Action": [
#         "s3:GetBucketAcl"
#       ],
#       "Effect": "Allow",
#       "Resource": "${aws_s3_bucket.S3vpcFlowLog.arn}"
#     }
#   ]
# }
# EOF
# }