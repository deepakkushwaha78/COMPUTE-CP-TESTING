data "aws_caller_identity" "current" {}
data "aws_region" "current" {}
data "aws_partition" "current" {}

locals {
  create_bucket  = var.create_bucket
  create_bucket_acl = var.acl != null && var.acl != "null"
  attach_policy  = var.attach_elb_log_delivery_policy || var.attach_lb_log_delivery_policy || var.attach_iam_policy || var.attach_cloudtrail_policy
  cors_rules  = var.cors_rules
}

# -- S3 Bucket creation
resource "aws_s3_bucket" "this" {
  count = local.create_bucket ? 1 : 0

  bucket                 = var.name
  bucket_prefix          = var.bucket_prefix
  force_destroy          = var.force_destroy
  object_lock_enabled    = var.object_lock_enabled
  tags = var.tags
}

# -- S3 bucket acceleration
resource "aws_s3_bucket_accelerate_configuration" "this" {
    count = local.create_bucket && var.enable_transfer_acceleration ? 1 : 0
    bucket = aws_s3_bucket.this[count.index].bucket
    status = var.enable_transfer_acceleration ? "Enabled" : "Suspended"
}

# -- lifecycle rules for S3 bucket
resource "aws_s3_bucket_lifecycle_configuration" "this" {
  bucket = aws_s3_bucket.this[0].id
  dynamic "rule" {
    for_each = var.lifecycle_rules

    content {
      id     = rule.value.id
      status = rule.value.status

      filter {
        prefix = try(rule.value.filter_prefix, "")
      }

      dynamic "transition" {
        for_each = rule.value.transitions

        content {
          days   = transition.value.days
          storage_class = transition.value.storage_class
        } 
      }

      dynamic "expiration" {
        for_each = try(rule.value.expiration_days, null) != null ? [1] : []
        content {
          days = rule.value.expiration_days
        }
      }
    }
  }
}

# -- Bucket public access block
resource "aws_s3_bucket_public_access_block" "this" {
 count                    = local.create_bucket && var.attach_public_policy ? 1 : 0
 bucket                   = aws_s3_bucket.this[0].id
 block_public_acls        = var.block_public_acls
 block_public_policy      = var.block_public_policy
 ignore_public_acls       = var.ignore_public_acls
 restrict_public_buckets  = var.restrict_public_buckets
}

# -- Bucket policy
resource "aws_s3_bucket_policy" "this" {
  count = local.create_bucket && local.attach_policy ? 1 : 0
  # -- Chain resources (s3_bucket -> s3_bucket_public_access_block -> s3_bucket_policy )
  bucket = aws_s3_bucket.this[0].id
  policy = data.aws_iam_policy_document.combined[0].json
  depends_on = [
    aws_s3_bucket_public_access_block.this
  ]
}

data "aws_iam_policy_document" "combined" { // Combines IAM policy documents based on conditions.
  count = local.create_bucket && local.attach_policy ? 1 : 0

  source_policy_documents = compact([
    var.attach_elb_log_delivery_policy ? data.aws_iam_policy_document.elb_log_delivery[0].json : "",
    var.attach_lb_log_delivery_policy ? data.aws_iam_policy_document.lb_log_delivery[0].json : "",
    var.attach_iam_policy ? var.iam_policy : "",
    var.attach_iam_policy ? data.aws_iam_policy_document.s3denyssl.json : "",
    var.attach_cloudtrail_policy ? data.aws_iam_policy_document.cloudtrail[0].json : "" // Adding the CloudTrail policy
  ])
}

data "aws_iam_policy_document" "s3denyssl" {
  statement {
    sid = "DenyNonSSLRequests"
    principals {
      type  = "AWS"
      identifiers = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"]
    }

    actions = ["s3:*"]
    effect = "Deny"
    resources = [
      aws_s3_bucket.this[0].arn,
      "${aws_s3_bucket.this[0].arn}/*",
    ]
    condition {
      test  = "Bool"
      variable = "aws:SecureTransport"

      values = ["false"]
    }
  }
}

# -- ELB
data "aws_iam_policy_document" "elb_log_delivery" {
 count = var.create_bucket && var.attach_elb_log_delivery_policy ? 1 : 0

 # Policy for AWS Regions created before August 2022
 dynamic "statement" {
 for_each = { for k, v in var.elb_service_accounts : k => v if k == data.aws_region.current.name }

 content {
  sid = format("ELBRegion%s", title(statement.key))

  principals {
  type  = "AWS"
  identifiers = [statement.value]
  }

  effect = "Allow"

  actions = [
  "s3:PutObject",
  ]

  resources = [
  aws_s3_bucket.this[count.index].arn,
  "${aws_s3_bucket.this[count.index].arn}/${var.log_delivery_folder}/elb-logs/*",
  ]
 }
 }

 # Policy for AWS Regions created after August 2022
 statement {
 sid = "ELBRegionOverride"

 principals {
  type  = "Service"
  identifiers = [var.elb_identifier]
 }

 effect = "Allow"

 actions = [
  "s3:PutObject",
 ]

 resources = [
  aws_s3_bucket.this[count.index].arn,
  "${aws_s3_bucket.this[count.index].arn}/${var.log_delivery_folder}/",
 ]
 }
}

# ALB/NLB
data "aws_iam_policy_document" "lb_log_delivery" {
 count = local.create_bucket && var.attach_lb_log_delivery_policy ? 1 : 0

 statement {
 sid = "AWSLogDeliveryWrite"

 principals {
  type  = "Service"
  identifiers = [var.lb_identifier]
 }

 effect = "Allow"

 actions = [
  "s3:PutObject",
 ]

 resources = [
  "${aws_s3_bucket.this[0].arn}/${var.log_delivery_folder}",
 ]
 dynamic "condition" {
  for_each = var.lb_log_delivery_conditions
  content {
  test  = condition.value.test
  variable = condition.value.variable
  values  = condition.value.values
  }
 }
 }

 statement {
 sid = "AWSLogDeliveryAclCheck"

 effect = "Allow"

 principals {
  type  = "Service"
  identifiers = [var.lb_identifier]
 }

 actions = [
  "s3:GetBucketAcl",
  "s3:ListBucket",
 ]

 resources = [
  aws_s3_bucket.this[0].arn,
 ]
 }
}

data "aws_iam_policy_document" "cloudtrail" {
 count = local.create_bucket && var.attach_cloudtrail_policy ? 1 : 0

 statement {
 sid  = "AllowCloudTrailToGetBucketAcl"
 effect = "Allow"
 actions = ["s3:GetBucketAcl", "s3:GetBucketLocation", "s3:PutObject"]
 resources = [
  aws_s3_bucket.this[0].arn,
  "${aws_s3_bucket.this[0].arn}/AWSLogs/${data.aws_caller_identity.current.account_id}/*"
 ]
 principals {
  type  = "Service"
  identifiers = ["cloudtrail.amazonaws.com"]
 }
 }
}

// Bucket ownership controls
resource "aws_s3_bucket_ownership_controls" "this" {
 count = local.create_bucket && var.control_object_ownership ? 1 : 0

 bucket = local.attach_policy ? aws_s3_bucket_policy.this[0].id : aws_s3_bucket.this[0].id

 rule {
 object_ownership = var.object_ownership
 }

 //  This `depends_on` is to prevent "A conflicting conditional operation is currently in progress against this resource."
 depends_on = [
 aws_s3_bucket_policy.this,
 aws_s3_bucket_public_access_block.this,
 aws_s3_bucket.this
 ]
}


# // Bucket ACL

resource "aws_s3_bucket_acl" "this" {
 count = local.create_bucket && local.create_bucket_acl ? 1 : 0

 bucket    = aws_s3_bucket.this[0].id
 expected_bucket_owner = data.aws_caller_identity.current.account_id

 acl = var.acl == "null" ? null : var.acl

 # This `depends_on` is to prevent "AccessControlListNotSupported: The bucket does not allow ACLs."
 depends_on = [aws_s3_bucket_ownership_controls.this]
}

// Bucket CROS (Cross-Origin Resource Sharing)
resource "aws_s3_bucket_cors_configuration" "this" {
 count = local.create_bucket && length(local.cors_rules) > 0 ? 1 : 0

 bucket    = aws_s3_bucket.this[0].id
 expected_bucket_owner = data.aws_caller_identity.current.account_id

 dynamic "cors_rule" {
 for_each = local.cors_rules

 content {
  id    = try(cors_rule.value.id, null)
  allowed_methods = cors_rule.value.allowed_methods
  allowed_origins = cors_rule.value.allowed_origins
  allowed_headers = try(cors_rule.value.allowed_headers, null)
  expose_headers = try(cors_rule.value.expose_headers, null)
  max_age_seconds = try(cors_rule.value.max_age_seconds, null)
 }
 }
}

// Bucket encryption

resource "aws_s3_bucket_server_side_encryption_configuration" "this" {
 count = local.create_bucket && length(var.server_side_encryption_configuration) > 0 ? 1 : 0

 bucket    = aws_s3_bucket.this[0].id
 expected_bucket_owner = data.aws_caller_identity.current.account_id

 dynamic "rule" {
 for_each = var.server_side_encryption_configuration

 content {
  bucket_key_enabled = try(rule.value.bucket_key_enabled, null)

  apply_server_side_encryption_by_default {
  sse_algorithm  = rule.value.apply_server_side_encryption_by_default.sse_algorithm
  kms_master_key_id = rule.value.apply_server_side_encryption_by_default.kms_master_key_id

  }
  # prefix = rule.value.prefix // aws_s3_bucket_server_side_encryption_configuration resource is used to define server-side encryption rules for S3 buckets, but it doesn't support a prefix attribute directly within each encryption rule. 
 }
 }
}

// Bucket logging
resource "aws_s3_bucket_logging" "this" {
 count = local.create_bucket && length(keys(var.logging)) > 0 ? 1 : 0

 bucket = aws_s3_bucket.this[0].id

 target_bucket = var.logging["target_bucket"]
 target_prefix = try(var.logging["target_prefix"], null)
}

// Bukcet Versioning
resource "aws_s3_bucket_versioning" "this" {
 count = local.create_bucket && var.versioning.enabled ? 1 : 0

 bucket    = aws_s3_bucket.this[0].id
 expected_bucket_owner = data.aws_caller_identity.current.account_id

 versioning_configuration {
 status  = var.versioning.status
 mfa_delete = var.versioning.mfa_delete ? "Enabled" : "Disabled"
 }
}


// bucket metrics

resource "aws_s3_bucket_metric" "this" {
 for_each = { for metric in var.metric_configuration : metric.id => metric }

 bucket = aws_s3_bucket.this[0].id
 name  = each.value.name

 dynamic "filter" {
 for_each = each.value.filter # Assuming you have multiple filters per metric

 content {
  prefix = filter.value.prefix
  tags  = filter.value.tags
 }
 }

}