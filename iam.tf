data "aws_iam_policy_document" "assume_backend_server_role_policy" {
  statement {
    sid = "1"
    actions = [
      "sts:AssumeRole"
    ]
    effect = "Allow"
    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "backend_server_role" {
  name               = "backend-server-iam-role"
  assume_role_policy = data.aws_iam_policy_document.assume_backend_server_role_policy.json
}

resource "aws_iam_instance_profile" "backend_server_profile" {
  name = "backend-server-iam-instance-profile"
  role = aws_iam_role.backend_server_role.name
}

data "aws_iam_policy_document" "backend_server_policy_document" {
  statement {
    sid = "1"
    actions = [
      "logs:CreateLogStream",
      "logs:PutLogEvents",
      "logs:DescribeLogGroups",
      "logs:DescribeLogStreams"
    ]
    effect = "Allow"
    resources = [
      "*"
    ]
  }
  statement {
    actions = [
      "s3:*",
    ]
    effect = "Allow"
    resources = [
      "*",
    ]
  }
  statement {
    actions = [
      "dynamodb:*",
    ]
    effect = "Allow"
    resources = [
      "*",
    ]
  }

}

resource "aws_iam_policy" "backend_server_policy" {
  name   = "backend-server-policy"
  policy = data.aws_iam_policy_document.backend_server_policy_document.json
}

resource "aws_iam_role_policy_attachment" "backend_server_policy_attachment" {
  role       = aws_iam_role.backend_server_role.name
  policy_arn = aws_iam_policy.backend_server_policy.arn
}