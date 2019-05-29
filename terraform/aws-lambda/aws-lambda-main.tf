terraform {
  required_version = "~> 0.12.0"
}

resource "aws_lambda_function" "function" {
  filename         = "${var.function_code_file}"
  source_code_hash = "${filebase64sha256(var.function_code_file)}"
  function_name    = "${var.function_name}"
  runtime          = "dotnetcore2.1"
  role             = "${aws_iam_role.function_role.arn}"
  handler          = "AwsGetHcProduct::AwsGetHcProduct.Function::FunctionHandler"
}

// IAM Role for function
resource "aws_iam_role" "function_role" {
  name = "tf-lambda-${var.function_name}"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow"
    }
  ]
}
EOF

  tags = {
    creator = "terraform"
  }
}

// Permission policy for function's IAM Role
resource "aws_iam_role_policy" "function_allow_logging" {
  name = "allow_logging"
  role = "${aws_iam_role.function_role.id}"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents"
      ],
      "Effect": "Allow",
      "Resource": "arn:aws:logs:*:*:*"
    }
  ]
}
EOF
}
