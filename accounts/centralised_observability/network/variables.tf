variable "region" {
  type        = string
  description = "AWS region where resources will be created"
  default     = "ap-south-1"
}

variable "cidr_block" {
  type        = string
  description = "CIDR block for the VPC"
}

variable "vpc_name" {
  type        = string
  description = "Name of the VPC"
}

variable "public_subnets_cidr" {
  type        = list(string)
  description = "CIDR blocks for public subnets"
  default     = ["10.250.0.0/24", "10.250.1.0/24"]
}

variable "private_subnets_cidr" {
  type        = list(string)
  description = "CIDR blocks for private subnets"
  default     = ["10.250.2.0/23", "10.250.4.0/23"]
}

variable "avaialability_zones" {
  type        = list(string)
  description = "List of availability zones"
  default     = ["ap-south-1a", "ap-south-1b"]
}

variable "logs_bucket" {
  type        = string
  description = "S3 bucket for VPC flow logs"
}

variable "logs_bucket_arn" {
  type        = string
  description = "ARN of S3 bucket for VPC flow logs"
  default     = ""
}

variable "enable_alb_logging" {
  type        = bool
  description = "Enable ALB access logging"
  default     = true
}

variable "enable_deletion_protection" {
  type        = bool
  description = "Enable deletion protection for ALB"
  default     = false
}

variable "public_web_sg_name" {
  type        = string
  description = "Name of the public web security group"
}

variable "igw_name" {
  type        = string
  description = "Name of the Internet Gateway"
}

variable "pub_rt_name" {
  type        = string
  description = "Name of the public route table"
}

variable "pub_subnet_name" {
  type        = list(string)
  description = "Names of public subnets"
}

variable "nat_name" {
  type        = string
  description = "Name of the NAT Gateway"
}

variable "pvt_rt_name" {
  type        = string
  description = "Name of the private route table"
}

variable "pvt_subnet_name" {
  type        = list(string)
  description = "Names of private subnets"
}

variable "enable_igw_publicRouteTable_PublicSubnets_resource" {
  type        = bool
  description = "Enable creation of IGW, public route table and public subnets"
  default     = true
}

variable "enable_nat_privateRouteTable_PrivateSubnets_resource" {
  type        = bool
  description = "Enable creation of NAT Gateway, private route table and private subnets"
  default     = true
}

variable "alb_name" {
  type        = string
  description = "Name of the Application Load Balancer"
}

variable "load_balancer_type" {
  type        = string
  description = "Type of load balancer"
  default     = "application"
}

variable "alb_http_port" {
  type        = number
  description = "HTTP listener port for ALB"
  default     = 80
}

variable "alb_http_protocol" {
  type        = string
  description = "HTTP listener protocol for ALB"
  default     = "HTTP"
}

variable "alb_https_port" {
  type        = number
  description = "HTTPS listener port for ALB"
  default     = 443
}

variable "alb_https_protocol" {
  type        = string
  description = "HTTPS listener protocol for ALB"
  default     = "HTTPS"
}

variable "redirect_status_code" {
  type        = string
  description = "HTTP to HTTPS redirect status code"
  default     = "HTTP_301"
}

variable "fixed_response_content_type" {
  type        = string
  description = "Content type for ALB fixed response"
  default     = "text/plain"
}

variable "fixed_response_message_body" {
  type        = string
  description = "Message body for ALB fixed response"
  default     = "Fixed response content"
}

variable "fixed_response_status_code" {
  type        = string
  description = "Status code for ALB fixed response"
  default     = "200"
}

variable "route_cidr" {
  type        = string
  description = "CIDR for default route in route tables"
  default     = "0.0.0.0/0"
}

variable "http_port" {
  type        = number
  description = "HTTP port for web security group"
  default     = 80
}

variable "https_port" {
  type        = number
  description = "HTTPS port for web security group"
  default     = 443
}

variable "public_web_sg_cidr_80_port" {
  type        = list(string)
  description = "CIDR blocks allowed to access port 80"
}

variable "enable_aws_route53_zone_resource" {
  type        = bool
  description = "Enable creation of Route53 private hosted zone"
  default     = true
}

variable "enable_https_listener" {
  type        = bool
  description = "Enable HTTPS listener on ALB"
  default     = true
}

variable "alb_certificate_arn" {
  type        = string
  description = "ARN of the SSL certificate for HTTPS listener"
  default     = ""
}

variable "pvt_zone_name" {
  type        = string
  description = "Name of the private hosted zone"
  default     = ""
}


variable "enable_pub_alb_resource" {
  type        = bool
  description = "This variable is to create ALB"
  default     = false
}

variable "create_bucket" {
  description = "Controls if S3 bucket should be created"
  type        = bool
  default     = true
}

variable "iam_policy" {
  description = "(Optional) A valid bucket policy JSON document. Note that if the policy document is not specific enough (but still valid), Terraform may view the policy as constantly changing in a terraform plan. In this case, please make sure you use the verbose/specific version of the policy. For more information about building AWS IAM policy documents with Terraform, see the AWS IAM Policy Document Guide."
  type        = string
  default     = null
}

variable "attach_iam_policy" {
  description = "Controls if S3 bucket should have bucket policy attached (set to `true` to use value of `policy` as bucket policy)"
  type        = bool
  default     = false
}

variable "metric_configuration" {
  description = "List of maps containing bucket metric configurations."
  type = list(object({
    id = string
    filter = list(object({
      prefix = string
      tags   = map(string)
    }))
    enabled = bool
    name    = string
  }))
  default = [
    {
      id      = "metric-1"
      filter  = []
      name    = "metric"
      enabled = true
    }
  ]
}

variable "enable_public_web_security_group_resource" {
  type        = bool
  description = "This variable is to create Web Security Group"
  default     = true
}



variable "key_name" {
  description = "Name of the key pair"
  type        = string
  default     = "jumphost-key"
}

variable "jumphost_public_key" {
  description = "Public key for the jumphost key pair"
  type        = string
}

variable "security_group_name" {
  description = "Name of the jumphost security group"
  type        = string
  default     = "jumphost-sg"
}

variable "ec2_instance_name" {
  description = "Name of the EC2 instance"
  type        = string
  default     = "jumphost"
}

variable "instance_type" {
  description = "Instance type for the jumphost server"
  type        = string
  default     = "t3a.xlarge"
}

variable "volume_size" {
  description = "Size of the EBS volume"
  type        = number
  default     = 30
}

variable "volume_type" {
  description = "Type of the EBS volume"
  type        = string
  default     = "gp3"
}

variable "volume_encrypted" {
  description = "Whether the EBS volume should be encrypted"
  type        = bool
  default     = true
}

variable "ami_id" {
  description = "AMI ID for the jumphost server"
  type        = string
}

variable "public_ip" {
  description = "Whether to associate a public IP address with the instance"
  type        = bool
  default     = false
}

variable "disable_api_termination" {
  description = "If true, enables EC2 Instance Termination protection"
  type        = bool
  default     = true
}
variable "org_name" {
  type        = string
  description = "Organization name (e.g., nitin-labs)"
}

variable "project_name" {
  type        = string
  description = "Project name (e.g., monitoring)"
}

variable "environment" {
  type        = string
  description = "Environment (e.g., prod, dev, stage)"
}

variable "vpn_ip_allowlist" {
  type        = list(string)
  description = "List of IP addresses allowed to SSH into the jumphost"
}

variable "ssh_port" {
  type        = number
  description = "The port used for SSH access"
  default     = 22
}