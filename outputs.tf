output "s3_landing_bucket_name" {
    value = module.s3_bucket_landing.s3_bucket_id
}

output "sqs_arn" {
    value = aws_sqs_queue.queue.arn
}