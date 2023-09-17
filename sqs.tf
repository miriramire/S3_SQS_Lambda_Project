resource "aws_sqs_queue" "sqs_to_lambda" {
  name                       = "demo_sqs_to_lambda"
  delay_seconds              = 20
  visibility_timeout_seconds = 30
  max_message_size           = 2048
  message_retention_seconds  = 86400
  receive_wait_time_seconds  = 10
  sqs_managed_sse_enabled = true
}