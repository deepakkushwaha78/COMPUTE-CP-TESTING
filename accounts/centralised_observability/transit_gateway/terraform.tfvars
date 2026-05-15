# IDENTITY
org_name     = "nitin-labs"
project_name = "monitoring"
environment  = "production"
region       = "ap-south-1"

tgw_description = "Centralized TGW for observability environment"
amazon_side_asn = 4200000000

# TGW Configuration
#transit_gateway_name               = "observability-tgw"
auto_accept_shared_attachments     = "enable"
default_route_table_association    = "enable"
default_route_table_propagation    = "enable"
dns_support                        = "enable"
multicast_support                  = "disable"
vpn_ecmp_support                   = "enable"
security_group_referencing_support = "disable"
# transit_gateway_cidr_blocks        = ["10.250.0.0/16"]

transit_gateway_cidr_blocks = [
  "10.116.0.0/16",
  "10.119.0.0/16",
  "10.250.0.0/21"
]

#  "10.124.0.0/16",
#  "10.113.0.0/16",
# Route Configuration
tgw_route_cidr_block = "10.0.0.0/8"

# VPC Attachments
vpc_attachments = [
  {
    name                           = "observability-tgw-attach-observability"
    vpc_id                         = "vpc-00e337382a6cda4c9"
    subnet_ids                     = ["subnet-0e5f79f7e3418c592", "subnet-0a37689e6c42095ba"]
    dns_support                    = "enable"
    ipv6_support                   = "disable"
    associate_with_tgw_route_table = true
    propagate_to_tgw_route_table   = true
  }
]

