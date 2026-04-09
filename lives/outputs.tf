output "primary_bucket_id" {
  description = "ID of the primary S3 bucket"
  value       = module.multi_region_app.primary_bucket_id
}

output "primary_bucket_arn" {
  description = "ARN of the primary S3 bucket"
  value       = module.multi_region_app.primary_bucket_arn
}

output "replica_bucket_id" {
  description = "ID of the replica S3 bucket"
  value       = module.multi_region_app.replica_bucket_id
}

output "replica_bucket_arn" {
  description = "ARN of the replica S3 bucket"
  value       = module.multi_region_app.replica_bucket_arn
}