module "network_skeleton" {
  source   = "../../../modules/network-skeleton"
  vpc_name = var.vpc_name


  cidr_block           = var.cidr_block
  public_subnets_cidr  = var.public_subnets_cidr
  private_subnets_cidr = var.private_subnets_cidr
  avaialability_zones  = var.avaialability_zones
  logs_bucket_arn      = module.aws_s3_bucket.s3_bucket_arn
  #tags                                                 = var.tags
  # Tagging is now standardized
  tags = merge(local.standard_tags, {
    "ResourceType" = "vpc"
  })

  igw_name                                             = var.igw_name
  pub_rt_name                                          = var.pub_rt_name
  pub_subnet_name                                      = var.pub_subnet_name
  nat_name                                             = var.nat_name
  pvt_rt_name                                          = var.pvt_rt_name
  pvt_subnet_name                                      = var.pvt_subnet_name
  enable_igw_publicRouteTable_PublicSubnets_resource   = var.enable_igw_publicRouteTable_PublicSubnets_resource
  enable_nat_privateRouteTable_PrivateSubnets_resource = var.enable_nat_privateRouteTable_PrivateSubnets_resource
  enable_alb_logging                                   = var.enable_alb_logging
  alb_name                                             = var.alb_name
  public_web_sg_name                                   = var.public_web_sg_name
  public_web_sg_cidr_80_port                           = var.public_web_sg_cidr_80_port
  enable_deletion_protection                           = var.enable_deletion_protection
  enable_aws_route53_zone_resource                     = var.enable_aws_route53_zone_resource
  enable_https_listener                                = var.enable_https_listener
  alb_certificate_arn                                  = var.alb_certificate_arn
  pvt_zone_name                                        = var.pvt_zone_name
  enable_pub_alb_resource                              = var.enable_pub_alb_resource
  enable_public_web_security_group_resource            = var.enable_public_web_security_group_resource
  route_cidr                                           = var.route_cidr
  http_port                                            = var.http_port
  https_port                                           = var.https_port
  load_balancer_type                                   = var.load_balancer_type
  alb_http_port                                        = var.alb_http_port
  alb_http_protocol                                    = var.alb_http_protocol
  alb_https_port                                       = var.alb_https_port
  alb_https_protocol                                   = var.alb_https_protocol
  redirect_status_code                                 = var.redirect_status_code
  fixed_response_content_type                          = var.fixed_response_content_type
  fixed_response_message_body                          = var.fixed_response_message_body
  fixed_response_status_code                           = var.fixed_response_status_code
}

module "aws_s3_bucket" {
  source = "../../../modules/s3"
  #  name   = var.name
  name = "${local.resource_prefix}-vpc-flow-logs"
}

module "jumphost_security_group" {
  source = "../../../modules/security_groups"

  name_sg = "${local.resource_prefix}-jumphost-sg"
  vpc_id  = module.network_skeleton.vpc_id
  #tags                               = var.tags
  tags = merge(local.standard_tags, {
    "Component"    = "security"
    "ResourceType" = "security-group"
  })
  enable_source_security_group_entry = true

  #  ingress_rule = {
  #   rules = {
  #      rule_list = [
  #   {
  #         description  = "Allow SSH traffic from VPN"
  #        from_port    = 22
  #        to_port      = 22
  #        protocol     = "TCP"
  #      cidr         = ["13.127.211.58/32"]
  #      source_SG_ID = []
  #   }
  # ]
  # }
  #}
  #}

  ingress_rule = {
    rules = {
      rule_list = [
        {
          description = "Allow SSH traffic from VPN"
          from_port   = var.ssh_port
          to_port     = var.ssh_port
          protocol    = "TCP"
          # Use the variable instead of a hardcoded string
          cidr         = var.vpn_ip_allowlist
          source_SG_ID = []
        }
      ]
    }
  }
}
module "jumphost_server" {
  source   = "../../../modules/ec2"
  ec2_name = "${local.resource_prefix}-jumphost"
  #tags                    = var.jumphost_tags
  # Tagging: Combined standard tags + specific component tag
  tags = merge(local.standard_tags, {
    "Component"    = "compute"
    "ResourceType" = "jumphost"
  })
  instance_type           = var.instance_type
  key_name                = aws_key_pair.jumphost_pem.key_name
  volume_size             = var.volume_size
  volume_type             = var.volume_type
  encrypted_volume        = var.volume_encrypted
  subnet                  = module.network_skeleton.pvt_subnet_ids[0][0]
  security_groups         = [module.jumphost_security_group.sg_id]
  ami_id                  = var.ami_id
  public_ip               = var.public_ip
  disable_api_termination = var.disable_api_termination
}

resource "aws_key_pair" "jumphost_pem" {
  key_name   = var.key_name
  public_key = var.jumphost_public_key
}
