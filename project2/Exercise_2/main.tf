provider "aws" {
  # access_key = "ASIAXRI6BIRLZ3PZPNXN"
  # secret_key = "g+spRcWzAUrLkxhpCWrfo9DSqytddpWvrO8oZZqB"
  # token      = "FwoGZXIvYXdzEE8aDJRVLQuZLo2+/fIjAiLVAbys8u1hl4wVPT42Qt/fH6+Ij7Klh2PaOQ9f94mQY3v1sdavTBGKov64MxJRa7Ss6hVlY/WHTyjP7g4zMbwgF8bwNszn1ZdgSCWI3J0eYNhVnp4sUhmaT9zrOpD3CKNI4i46co/fxjUGfQ5hHUOnISzbs8NYdH5K7oti9WN4zAKkM4Ov2KKSWyEMRzcbCqNr0Mnn1h1DGNgNorl2zNvI/roJcRLeqrqDgerblGGld+7VxummRwVQ3NKPORu2Dk4pHYePdVWfmoGBNmVEvPo9tZj1Gj1IZyivx4iSBjItuk3nCgRedysz6NflaQCWjOxKEwYWRMJ07wfvv5nlH3T8qcqw1jlxvBlJvhQD"
  region     = var.aws_region
}

data "archive_file" "lambda" {
  type        = "zip"
  source_file = "./greet_lambda.py"
  output_path = "./greet_lambda.py.zip"
}

resource "aws_lambda_function" "greet_lambda" {
  function_name = "greet_lambda"
  filename = data.archive_file.lambda.output_path
  runtime = "python3.8"
  handler = "greet_lambda.lambda_handler"

  role = aws_iam_role.lambda_exec.arn
}

resource "aws_cloudwatch_log_group" "greet_lambda" {
  name = "/aws/lambda/${aws_lambda_function.greet_lambda.function_name}"

  retention_in_days = 30
}

resource "aws_iam_role" "lambda_exec" {
  name = "serverless_lambda"

  assume_role_policy = jsonencode({
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Sid    = ""
      Principal = {
        Service = "lambda.amazonaws.com"
      }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "lambda_policy" {
  role       = aws_iam_role.lambda_exec.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}
