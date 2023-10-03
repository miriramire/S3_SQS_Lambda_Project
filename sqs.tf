# https://sharmilas.medium.com/creating-an-sqs-queue-using-terraform-a-step-by-step-guide-54f1005dc616
data "aws_iam_policy_document" "queue" {
  statement {
    effect = "Allow"

    principals {
      type        = "*"
      identifiers = [ "*" ]
    }

    actions = ["sqs:SendMessage"]
    resources = ["arn:aws:sqs:*:*:${var.sqs_queue.name}"]

    condition {
      test = "ArnEquals"
      variable = "aws:SourceArn"
      values = [module.s3_bucket_landing.s3_bucket_arn]
    }

  }
}

resource "aws_sqs_queue_policy" "sh_sqs_policy" {
  queue_url = aws_sqs_queue.queue.id
  policy    = data.aws_iam_policy_document.queue.json
}

resource "aws_sqs_queue" "queue" {
  name                       = var.sqs_queue.name
  delay_seconds              = 10
  visibility_timeout_seconds = 30
  max_message_size           = 2048
  message_retention_seconds  = 86400
  receive_wait_time_seconds  = 2
}

