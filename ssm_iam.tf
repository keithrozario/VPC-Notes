# AWS Managed Policy
data "aws_iam_policy" "ssm_managed_instance_policy" {
  arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

data "aws_iam_policy" "cloudwatch_agent_policy" {
  arn = "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"
}


resource "aws_iam_role" "ec2_iam_role" {
  name = "test_role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF

  tags = {
    tag-key = "tag-value"
  }
}


resource "aws_iam_role_policy_attachment" "ec2_ssm_attach" {
  role       = "${aws_iam_role.ec2_iam_role.name}"
  policy_arn = "${data.aws_iam_policy.ssm_managed_instance_policy.arn}"
}

resource "aws_iam_role_policy_attachment" "cloud_watch_agent_attach" {
  role       = "${aws_iam_role.ec2_iam_role.name}"
  policy_arn = "${data.aws_iam_policy.ssm_managed_instance_policy.arn}"
}

resource "aws_iam_instance_profile" "ec2_profile" {
  name = "ec2_profile_ssm_cloudwatch"
  role = "${aws_iam_role.ec2_iam_role.name}"
}