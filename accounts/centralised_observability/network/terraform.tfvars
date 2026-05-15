# --- IDENTITY ---
org_name     = "nitin-labs"
project_name = "monitoring"
environment  = "production"
region       = "ap-south-1"

vpc_name        = "observability-vpc"
igw_name        = "observability-igw"
pub_rt_name     = "observability-pub"
pub_subnet_name = ["observability-pub-sub-1a", "observability-pub-sub-1b"]
nat_name        = "observability-nat1"
pvt_rt_name     = "observability-pvt"
pvt_subnet_name = ["observability-pvt-sub-1a", "observability-pvt-sub-1b"]

# Network Configuration
cidr_block           = "10.250.0.0/21"
public_subnets_cidr  = ["10.250.0.0/24", "10.250.1.0/24"]
private_subnets_cidr = ["10.250.2.0/23", "10.250.4.0/23"]
avaialability_zones  = ["ap-south-1a", "ap-south-1b"]

# VPC Flow Logs
logs_bucket = "observability-vpc-flow-logs"

# Resource Configuration
enable_igw_publicRouteTable_PublicSubnets_resource   = true
enable_nat_privateRouteTable_PrivateSubnets_resource = true

# Load Balancer Configuration
enable_pub_alb_resource                   = false
enable_public_web_security_group_resource = false
alb_name                                  = "observability-alb"
public_web_sg_name                        = "observability-web-sg1"
enable_alb_logging                        = true
public_web_sg_cidr_80_port                = ["14.194.19.30/32"]
enable_deletion_protection                = false
enable_https_listener                     = false
alb_certificate_arn                       = ""
route_cidr                                = "0.0.0.0/0"
http_port                                 = 80
https_port                                = 443
load_balancer_type                        = "application"
alb_http_port                             = 80
alb_http_protocol                         = "HTTP"
alb_https_port                            = 443
alb_https_protocol                        = "HTTPS"
redirect_status_code                      = "HTTP_301"
fixed_response_content_type               = "text/plain"
fixed_response_message_body               = "Fixed response content"
fixed_response_status_code                = "200"

# DNS Configuration
enable_aws_route53_zone_resource = true
pvt_zone_name                    = "observability.internal"


key_name                = "observability-jumphost-key"
jumphost_public_key     = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMtFwhV5bf+lFZAJe8Y/d3akFxz/aLvI3GfQKn3Yn4YL fci_observability"
security_group_name     = "observability-jumphost-sg"
ec2_instance_name       = "observability-jumphost"
instance_type           = "t3.micro"
volume_size             = 8
volume_type             = "gp3"
volume_encrypted        = true
ami_id                  = "ami-0f918f7e67a3323f0"
public_ip               = false
disable_api_termination = true


# jumphost security group rules
vpn_ip_allowlist = ["13.127.211.58/32"]
ssh_port         = 22