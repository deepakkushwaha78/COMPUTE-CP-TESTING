// Bucket creation variables
variable "create_bucket" {
 description = "Controls if S3 bucket should be created"
 type    = bool
 default   = true
}

variable "name" {
 description = "(Optional, Forces new resource) The name of the bucket. If omitted, Terraform will assign a random, unique name."
 type    = string
 default   = ""
}

variable "bucket_prefix" {
 description = "(Optional, Forces new resource) Creates a unique bucket name beginning with the specified prefix. Conflicts with bucket."
 type    = string
 default   = null
}

variable "force_destroy" {
 description = "(Optional, Default:false ) A boolean that indicates all objects should be deleted from the bucket so that the bucket can be destroyed without error. These objects are not recoverable."
 type    = bool
 default   = false
}

variable "object_lock_enabled" {
 description = "Whether S3 bucket should have an Object Lock configuration enabled."
 type    = bool
 default   = false
}


variable "tags" {
 description = "(Optional) A mapping of tags to assign to the bucket."
 type    = map(string)
 default   = {}

}

// bucket public access block
variable "attach_public_policy" {
 description = "Controls if a user defined public bucket policy will be attached (set to `false` to allow upstream to apply defaults to the bucket)"
 type    = bool
 default   = false
}

variable "block_public_acls" {
 description = "Whether Amazon S3 should block public ACLs for this bucket."
 type    = bool
 default   = true
}

variable "block_public_policy" {
 description = "Whether Amazon S3 should block public bucket policies for this bucket."
 type    = bool
 default   = true
}

variable "ignore_public_acls" {
 description = "Whether Amazon S3 should ignore public ACLs for this bucket."
 type    = bool
 default   = true
}

variable "restrict_public_buckets" {
 description = "Whether Amazon S3 should restrict public bucket policies for this bucket."
 type    = bool
 default   = true
}

// Bucket policy
variable "iam_policy" {
 description = "(Optional) A valid bucket policy JSON document. Note that if the policy document is not specific enough (but still valid), Terraform may view the policy as constantly changing in a terraform plan. In this case, please make sure you use the verbose/specific version of the policy. For more information about building AWS IAM policy documents with Terraform, see the AWS IAM Policy Document Guide."
 type    = string
 default   = null
}

// bucket object ownership
variable "control_object_ownership" {
 description = "Whether to manage S3 Bucket Ownership Controls on this bucket."
 type    = bool
 default   = true
}

variable "object_ownership" {
 description = "Object ownership. Valid values: BucketOwnerEnforced, BucketOwnerPreferred, or ObjectWriter."
 type    = string
 default = "ObjectWriter"

 validation {
  condition   = var.object_ownership == "BucketOwnerEnforced" || var.object_ownership == "BucketOwnerPreferred" || var.object_ownership == "ObjectWriter"
  error_message = "Invalid value for object_ownership. Valid values are BucketOwnerEnforced, BucketOwnerPreferred, or ObjectWriter."
 }
}


variable "attach_elb_log_delivery_policy" {
 description = "Controls if S3 bucket should have ELB log delivery policy attached"
 type    = bool
 default   = true
}

variable "attach_lb_log_delivery_policy" {
 description = "Controls if S3 bucket should have ALB/NLB log delivery policy attached"
 type    = bool
 default   = true
}

variable "attach_iam_policy" {
 description = "Controls if S3 bucket should have bucket policy attached (set to `true` to use value of `policy` as bucket policy)"
 type    = bool
 default   = false
}

variable "attach_cloudtrail_policy" {
 description = "Set to true to attach the CloudTrail policy to the S3 bucket."
 type    = bool
 default   = true
}
// bucket acl
variable "acl" {
 description = "(Optional) The canned ACL to apply. Conflicts with `grant`"
 type    = string
 default   = "private"
}

// Bucket cors
variable "cors_rules" {
 description = "List of maps containing rules for Cross-Origin Resource Sharing."
 type = list(object({
  id       = string
  allowed_methods = list(string)
  allowed_origins = list(string)
  allowed_headers = list(string)
  expose_headers = list(string)
  max_age_seconds = number
 }))
 default = []
}

// Bucket encryption
variable "server_side_encryption_configuration" {
 description = "List of server-side encryption configuration rules."
 type = list(object({

  apply_server_side_encryption_by_default = object({
   sse_algorithm   = string
   kms_master_key_id = string
  })
 }))
 default = []
}

// Bucket logging
variable "logging" {
 description = "Map containing access bucket logging configuration."
 type    = map(string)
 default   = {}
}

// Bucket Versioning
variable "versioning" {
 description = "Map containing S3 bucket versioning configuration."
 type = object({
  enabled  = bool
  status   = string
  mfa_delete = bool
 })
 default = {
  enabled  = true
  status   = "Enabled"
  mfa_delete = false
 }

 validation {
  condition   = var.versioning.status == "Enabled" || var.versioning.status == "Suspended"
  error_message = "Invalid value for 'status'. Must be either 'Enabled' or 'Suspended'."
 }
}

variable "enable_transfer_acceleration" {
 description = "Enable S3 Transfer Acceleration"
 type    = bool
 default   = false
}


variable "lifecycle_rules" {
 description = "List of lifecycle rules for S3 bucket"
 type = list(object({
  id = string
  status = string
  transitions = list(object({
   days     = number
   storage_class = string
  }))
  expiration_days = optional(number)
 }))
 default = [
  {
   id = "Transition to IA"
   status = "Enabled"
   transitions = [
    {
     days     = 30
     storage_class = "STANDARD_IA"
    },
    {
     days     = 90
     storage_class = "GLACIER"
    }
   ]
   expiration_days = null
  }
 ]
#  validation {
#   condition   = var.lifecycle_rules.status == "Enabled" || var.lifecycle_rules.status == "Disabled"
#   error_message = "Invalid value for 'status'. Must be either 'Enabled' or 'Disabled'."
#  }
}


variable "metric_configuration" {
 description = "List of maps containing bucket metric configurations."
 type = list(object({
  id = string
  filter = list(object({
   prefix = string
   tags  = map(string)
  }))
  enabled = bool
  name  = string
 }))
 default = [
  {
   id   = "metric-1"
   filter = []
   name  = "metric"
   enabled = true
  }
 ]
}


variable "elb_service_accounts" {
 description = "Map of AWS regions to ELB service account IDs."
 type    = map(string)
 default   = {}
}

variable "elb_identifier" {
 description = "Default identifier for the Elastic Load Balancing service, the value does not need to be set, unless aws updates the elb_identifier value"
 type    = string
 default   = "logdelivery.elasticloadbalancing.amazonaws.com"
}

variable "lb_identifier" {
 description = "AWS service identifier for log delivery to ALB/NLB."
 type    = string
 default   = "delivery.logs.amazonaws.com" # AWS generally maintains stable service endpoints, but updates can occur. Please monitor AWS
}

variable "lb_log_delivery_conditions" {
 description = "List of conditions for LB log delivery statements."
 type = list(object({
  test   = string
  variable = string
  values  = list(string)
 }))
 default = []
}

variable "log_delivery_folder" {
 description = "Folder path within the S3 bucket where ELB/NLB logs will be delivered."
 type    = string
 default   = "logs"
}