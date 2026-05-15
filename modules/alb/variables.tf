
variable "load_balancer_type" {
  description = "Type of load balancer"
  type        = string
  default     = "application"
}

variable "http_port" {
  description = "HTTP listener port"
  type        = number
  default     = 80
}

variable "http_protocol" {
  description = "HTTP listener protocol"
  type        = string
  default     = "HTTP"
}

variable "https_port" {
  description = "HTTPS listener port"
  type        = number
  default     = 443
}

variable "https_protocol" {
  description = "HTTPS listener protocol"
  type        = string
  default     = "HTTPS"
}

variable "redirect_status_code" {
  description = "HTTP to HTTPS redirect status code"
  type        = string
  default     = "HTTP_301"
}

variable "fixed_response_content_type" {
  description = "Content type for ALB fixed response"
  type        = string
  default     = "text/plain"
}

variable "fixed_response_message_body" {
  description = "Message body for ALB fixed response"
  type        = string
  default     = "Fixed response content"
}

variable "fixed_response_status_code" {
  description = "Status code for ALB fixed response"
  type        = string
  default     = "200"
}

variable "alb_name" {
  description = "Name of ALB"
  type        = string
}

variable "internal" {
  type = bool
}

variable "security_groups_id" {
  description = "Security groups to be associated with ALB"
  type        = list(string)
}

variable "subnets_id" {
  description = "Subnets to be mapped with ALB"
  type        = list(string)
}

variable "enable_deletion_protection" {
  default = false
  type    = bool
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}

variable "logs_bucket" {
  type        = string
  description = "Name of bucket where we would be storing our logs"
  default     = "test"
}

variable "enable_logging" {
  type    = bool
  default = true
}


variable "alb_certificate_arn" {
 description = "Cretificate arn for alb"
  type        = string
  default     = ""
}