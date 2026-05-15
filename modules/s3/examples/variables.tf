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

variable "iam_policy" {
 description = "(Optional) A valid bucket policy JSON document. Note that if the policy document is not specific enough (but still valid), Terraform may view the policy as constantly changing in a terraform plan. In this case, please make sure you use the verbose/specific version of the policy. For more information about building AWS IAM policy documents with Terraform, see the AWS IAM Policy Document Guide."
 type    = string
 default   = null
}

variable "attach_iam_policy" {
 description = "Controls if S3 bucket should have bucket policy attached (set to `true` to use value of `policy` as bucket policy)"
 type    = bool
 default   = false
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
