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
# Event source from SQS
resource "aws_lambda_event_source_mapping" "event_source_mapping" {
  event_source_arn = "${aws_sqs_queue.queue.arn}"
  enabled          = true
  function_name    = "${aws_lambda_function.s3_transform_function.arn}"
  batch_size       = 1
}