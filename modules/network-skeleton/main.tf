resource "aws_vpc" "main" {
  cidr_block           = var.cidr_block
  instance_tenancy     = var.instance_tenancy
  enable_dns_support   = var.enable_dns_support
  enable_dns_hostnames = var.enable_dns_hostnames

  tags = merge(
    {
      "Name" = format("%s", var.vpc_name)
    },
    var.tags,
  )
}

resource "aws_flow_log" "vpc_flow_logs" {
  count                = var.enable_vpc_logs == true ? 1 : 0
  log_destination      = var.logs_bucket_arn
  log_destination_type = var.log_destination_type
  traffic_type         = var.traffic_type
  vpc_id               = aws_vpc.main.id
}

resource "aws_internet_gateway" "igw" {
  count  = var.enable_igw_publicRouteTable_PublicSubnets_resource == true ? 1 : 0
  vpc_id = aws_vpc.main.id
  tags = merge(
    {
      "Name" = format("%s", var.igw_name)
    },
    var.tags,
  )
}

module "publicRouteTable" {
  count      = var.enable_igw_publicRouteTable_PublicSubnets_resource == true ? 1 : 0
  source     = "../route_table"
  cidr       = var.route_cidr
  gateway_id = aws_internet_gateway.igw[count.index].id
  name       = format("%s", var.pub_rt_name)
  vpc_id     = aws_vpc.main.id
  tags       = var.tags
}

module "PublicSubnets" {
  count              = var.enable_igw_publicRouteTable_PublicSubnets_resource == true ? 1 : 0
  source             = "../subnet"
  availability_zones = var.avaialability_zones
  subnet_name        = var.pub_subnet_name
  route_table_id     = module.publicRouteTable[count.index].id
  subnets_cidr       = var.public_subnets_cidr
  vpc_id             = aws_vpc.main.id
  tags               = var.tags
}

module "nat-gateway" {
  count              = var.enable_nat_privateRouteTable_PrivateSubnets_resource == true ? 1 : 0
  source             = "../nat_gateway"
  subnets_for_nat_gw = module.PublicSubnets[count.index].ids
  nat_name           = var.nat_name
  tags               = var.tags
}

module "privateRouteTable" {
  count      = var.enable_nat_privateRouteTable_PrivateSubnets_resource == true ? 1 : 0
  source     = "../route_table"
  cidr       = var.route_cidr
  gateway_id = module.nat-gateway[count.index].ngw_id
  name       = format("%s", var.pvt_rt_name)
  vpc_id     = aws_vpc.main.id
  tags       = var.tags
}

module "PrivateSubnets" {
  count              = var.enable_nat_privateRouteTable_PrivateSubnets_resource == true ? 1 : 0
  source             = "../subnet"
  availability_zones = var.avaialability_zones
  subnet_name        = var.pvt_subnet_name
  route_table_id     = module.privateRouteTable[count.index].id
  subnets_cidr       = var.private_subnets_cidr
  vpc_id             = aws_vpc.main.id
  tags               = var.tags
}

locals {
  security_group_rules = concat(
    [
      {
        description  = "Rule for port ${var.http_port}"
        from_port    = var.http_port
        to_port      = var.http_port
        protocol     = "tcp"
        cidr         = var.public_web_sg_cidr_80_port
        source_SG_ID = []
      }
    ],
    var.enable_https_listener ? [
      {
        description  = "Rule for port ${var.https_port}"
        from_port    = var.https_port
        to_port      = var.https_port
        protocol     = "tcp"
        cidr         = var.public_web_sg_cidr_443_port
        source_SG_ID = []
      }
    ] : []
  )
}

module "public_web_security_group" {
  count               = var.enable_public_web_security_group_resource == true ? 1 : 0
  source              = "../security_groups"
  enable_whitelist_ip = true
  name_sg             = var.public_web_sg_name
  vpc_id              = aws_vpc.main.id
  ingress_rule = {
    rules = {
      rule_list = local.security_group_rules
    }
  }
}

module "pub_alb" {
  count                      = var.enable_pub_alb_resource == true ? 1 : 0
  source                     = "../alb"
  alb_name                   = var.alb_name
  internal                   = var.alb_type
  logs_bucket                = var.logs_bucket
  security_groups_id         = [module.public_web_security_group[count.index].sg_id]
  subnets_id                 = var.alb_type == false ? module.PublicSubnets[count.index].ids : module.PrivateSubnets[count.index].ids
  tags                       = var.tags
  enable_logging             = var.enable_alb_logging
  enable_deletion_protection = var.enable_deletion_protection
  alb_certificate_arn        = var.enable_https_listener ? var.alb_certificate_arn : ""
  load_balancer_type         = var.load_balancer_type
  http_port                  = var.alb_http_port
  http_protocol              = var.alb_http_protocol
  https_port                 = var.alb_https_port
  https_protocol             = var.alb_https_protocol
  redirect_status_code       = var.redirect_status_code
  fixed_response_content_type = var.fixed_response_content_type
  fixed_response_message_body = var.fixed_response_message_body
  fixed_response_status_code  = var.fixed_response_status_code
}

resource "aws_route53_zone" "private_hosted_zone" {
  count = var.enable_aws_route53_zone_resource == true ? 1 : 0
  name  = var.pvt_zone_name
  vpc {
    vpc_id = aws_vpc.main.id
  }
}
