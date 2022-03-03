##########
# OUTPUT
##########

#Network VPC Info
output "monitoring_bucket_domain_name" {
  value = aws_s3_bucket.monitoring_bucket.bucket_domain_name
}

output "monitoring_bucket_name" {
  value = aws_s3_bucket.monitoring_bucket.bucket
}

output "monitoring_bucket_prefix" {
  value = aws_s3_bucket.monitoring_bucket.bucket_prefix
}