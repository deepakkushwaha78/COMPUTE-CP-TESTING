description                        = "Centralized TGW for multi-VPC"
amazon_side_asn                    = 4200000000
auto_accept_shared_attachments     = "enable"
default_route_table_association    = "enable"
default_route_table_propagation    = "enable"
dns_support                        = "enable"
multicast_support                  = "disable"
vpn_ecmp_support                   = "enable"
security_group_referencing_support = "disable"
transit_gateway_cidr_blocks        = ["10.200.0.0/16"]
transit_gateway_name               = "prod-tgw"


tags = {
  Environment = "prod"
  Owner       = "Nikita"
}

tgw_route_cidr_block = "10.0.0.0/8"

vpc_attachments = [
  {
    name                           = "tgw-attachment-vpc-a"
    vpc_id                         = "vpc-0b2e7e2387bf08301"
    subnet_ids                     = ["subnet-034233dfae169f63f", "subnet-07d80237e1856b427"]
    route_table_id                 = "rtb-03557993cb1fba8f4"
    dns_support                    = "enable"
    ipv6_support                   = "disable"
    associate_with_tgw_route_table = true
    propagate_to_tgw_route_table   = true
  },
  {
    name                           = "tgw-attachment-vpcB"
    vpc_id                         = "vpc-0cda6bcbeb0cc309b"
    subnet_ids                     = ["subnet-0efbb6d6ffd83edf1", "subnet-068e80c046b559f24"]
    route_table_id                 = "rtb-0eabcfe9c5f495ed7"
    dns_support                    = "enable"
    ipv6_support                   = "disable"
    associate_with_tgw_route_table = false
    propagate_to_tgw_route_table   = true
  }
]
