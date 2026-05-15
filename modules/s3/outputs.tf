output "s3_bucket_id" {
  description = "The name of the bucket."
  value       = try(aws_s3_bucket_policy.this[0].id, aws_s3_bucket.this[0].id, "")
}

output "s3_bucket_arn" {
  description = "The ARN of the bucket. Will be of format arn:aws:s3:::bucketname."
  value       = try(aws_s3_bucket.this[0].arn, "")
}

output "s3_bucket_bucket_domain_name" {
  description = "The bucket domain name. Will be of format bucketname.s3.amazonaws.com."
  value       = try(aws_s3_bucket.this[0].bucket_domain_name, "")
}

output "s3_bucket_region" {
  description = "The AWS region this bucket resides in."
  value       = try(aws_s3_bucket.this[0].region, "")
}

output "id" {
  description = "The name of the bucket."
  value       = try(aws_s3_bucket_policy.this[0].id, aws_s3_bucket.this[0].id, "")
}

output "arn" {
  description = "The ARN of the bucket. Will be of format arn:aws:s3:::bucketname."
  value       = try(aws_s3_bucket.this[0].arn, "")
}

output "name" {
  description = "The bucket domain name. Will be of format bucketname.s3.amazonaws.com."
  value       = try(aws_s3_bucket.this[0].bucket_domain_name, "")
}

###################################

output "elb_identifier" {
  description = "ELB log delivery service identifier."
  value = try(flatten([
    for statement in data.aws_iam_policy_document.elb_log_delivery[0].statement :
    [
      for principal in statement.principals :
      flatten([principal.identifiers]) if can(principal.identifiers) && principal.type == "Service"
    ]
  ])[0], null)
}


output "lb_identifier" {
  description = "ALB/NLB log delivery service identifier."
  value = try([
    for statement in data.aws_iam_policy_document.lb_log_delivery[0].statement :
    [
      for principal in statement.principals :
      flatten([principal.identifiers])[0]
      if can(principal.identifiers) && principal.type == "Service"
    ][0]
    if can(statement.principals)
  ][0], null)
}
