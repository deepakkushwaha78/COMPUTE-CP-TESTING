variable "cidr_block" {
  description = "The CIDR block for the VPC."
  type        = string
  default     = "10.0.0.0/16"
}

variable "vpc_name" {
  description = "Name of the VPC to be created"
  type        = string
  default     = "testing-vpc"
}

variable "tags" {
  description = "Additional tags for the VPC"
  type        = map(string)
  default     = {}
}

variable "public_subnets_cidr" {
  description = "CIDR list for public subnet"
  type        = list(string)
}

variable "private_subnets_cidr" {
  description = "CIDR list for private subnet"
  type        = list(string)
}

variable "avaialability_zones" {
  description = "List of avaialability zones"
  type        = list(string)
}

variable "public_web_sg_name" {
  type = string
}

variable "logs_bucket" {
  description = "Name of bucket where we would be storing our logs"
  type        = string
  default     = ""
}

variable "logs_bucket_arn" {
  description = "ARN of bucket where we would be storing vpc our logs"
  type        = string
  default     = ""
}

variable "pvt_zone_name" {
  description = "Name of private zone"
  type        = string
  default     = ""
}

variable "enable_dns_support" {
  type    = bool
  default = true
}

variable "enable_dns_hostnames" {
  type    = bool
  default = true
}

variable "instance_tenancy" {
  type    = string
  default = "default"
}

variable "log_destination_type" {
  type    = string
  default = "s3"
}

variable "traffic_type" {
  type    = string
  default = "ALL"
}

variable "enable_vpc_logs" {
  type    = bool
  default = true
}

variable "enable_alb_logging" {
  type    = bool
  default = true
}

variable "alb_certificate_arn" {
  description = "Certificate ARN for ALB HTTPS listener"
  type        = string
  default     = ""
}

variable "enable_deletion_protection" {
  type    = bool
  default = false
}

variable "enable_igw_publicRouteTable_PublicSubnets_resource" {
  type        = bool
  description = "This variable is used to create IGW, Public Route Table and Public Subnets"
  default     = true
}

variable "enable_nat_privateRouteTable_PrivateSubnets_resource" {
  type        = bool
  description = "This variable is used to create NAT, Private Route Table and Private Subnets"
  default     = true
}

variable "enable_public_web_security_group_resource" {
  type        = bool
  description = "This variable is to create Web Security Group"
  default     = true
}

variable "enable_pub_alb_resource" {
  type        = bool
  description = "This variable is to create ALB"
  default     = true
}

variable "enable_aws_route53_zone_resource" {
  type        = bool
  description = "This variable is to create Route 53 Zone"
  default     = false
}

variable "enable_https_listener" {
  type        = bool
  description = "Enable HTTPS listener on ALB"
  default     = false
}

variable "igw_name" {
  type        = string
  description = "Internet Gateway name"
}

variable "pub_rt_name" {
  type        = string
  description = "Public route table name"
}

variable "pub_subnet_name" {
  type        = list(string)
  description = "public subnet name"
}

variable "nat_name" {
  type        = string
  description = "Name of Nat Gateway"
}

variable "pvt_rt_name" {
  type        = string
  description = "Name of Pvt Route table"
}

variable "pvt_subnet_name" {
  type        = list(string)
  description = "Name of private subnets"
}

variable "alb_name" {
  type        = string
  description = "Name of ALB"
}

variable "alb_type" {
  type        = bool
  description = "Type of ALB"
  default     = false
}

variable "route_cidr" {
  description = "CIDR for default route in public and private route tables"
  type        = string
  default     = "0.0.0.0/0"
}

variable "http_port" {
  description = "HTTP port for web security group ingress rule"
  type        = number
  default     = 80
}

variable "https_port" {
  description = "HTTPS port for web security group ingress rule"
  type        = number
  default     = 443
}

variable "load_balancer_type" {
  description = "Type of load balancer"
  type        = string
  default     = "application"
}

variable "alb_http_port" {
  description = "HTTP listener port for ALB"
  type        = number
  default     = 80
}

variable "alb_http_protocol" {
  description = "HTTP listener protocol for ALB"
  type        = string
  default     = "HTTP"
}

variable "alb_https_port" {
  description = "HTTPS listener port for ALB"
  type        = number
  default     = 443
}

variable "alb_https_protocol" {
  description = "HTTPS listener protocol for ALB"
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

variable "public_web_sg_cidr_80_port" {
  description = "CIDR block that will be allowed to access port 80"
  type        = list(string)
  default     = ["0.0.0.0/0"] # Default allows access from anywhere
}

variable "public_web_sg_cidr_443_port" {
  description = "CIDR block that will be allowed to access port 443"
  type        = list(string)
  default     = ["0.0.0.0/0"] # Default allows access from anywhere
}
