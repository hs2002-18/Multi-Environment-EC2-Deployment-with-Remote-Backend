output "bucket_name" {
  value = aws_s3_bucket.backend_bucket.bucket
}

output "dynamodb_table_name" {
  value = aws_dynamodb_table.locks_table.name
}