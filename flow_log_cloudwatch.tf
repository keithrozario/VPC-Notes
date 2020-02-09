# resource "aws_flow_log" "vpcfl" {
#   iam_role_arn    = "${aws_iam_role.flowLogRole.arn}"
#   log_destination = "${aws_cloudwatch_log_group.vpcFlowLog.arn}"
#   traffic_type    = "ALL"
#   vpc_id          = "${aws_vpc.main.id}"
# }

# resource "aws_cloudwatch_log_group" "vpcFlowLog" {
#   name = "myVPCflowlog"
# }

# resource "aws_iam_role" "flowLogRole" {
#   name = "flowLogRole"

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

# resource "aws_iam_role_policy" "flowLogRolePolicy" {
#   name = "flowLogRolePolicy"
#   role = "${aws_iam_role.flowLogRole.id}"

#   policy = <<EOF
# {
#   "Version": "2012-10-17",
#   "Statement": [
#     {
#       "Action": [
#         "logs:CreateLogStream",
#         "logs:PutLogEvents",
#         "logs:DescribeLogGroups",
#         "logs:DescribeLogStreams"
#       ],
#       "Effect": "Allow",
#       "Resource": "${aws_cloudwatch_log_group.vpcFlowLog.arn}"
#     }
#   ]
# }
# EOF
# }
