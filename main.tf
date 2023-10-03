# S3 Bucket Notification
resource "aws_s3_bucket_notification" "bucket_notification" {
  bucket = module.s3_bucket_landing.s3_bucket_id

  queue {
    queue_arn     = aws_sqs_queue.queue.arn
    events        = ["s3:ObjectCreated:*"]
    filter_prefix = "${var.s3_bucket_landing.input}/"
  }
}

# Lambda SQS trigger
resource "aws_s3_bucket_notification" "sqs_event_trigger" {
  bucket = module.s3_bucket_landing.s3_bucket_id

  queue {
    queue_arn = aws_sqs_queue.queue.arn
    events             = ["s3:ObjectCreated:*"]
    filter_prefix      = "${var.s3_bucket_landing.input}"
    filter_suffix      = ""
  }
}