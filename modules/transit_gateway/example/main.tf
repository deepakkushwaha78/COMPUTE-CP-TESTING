module "transit_gateway" {
  source = "../"

  description                        = var.description
  amazon_side_asn                    = var.amazon_side_asn
  auto_accept_shared_attachments     = var.auto_accept_shared_attachments
  default_route_table_association    = var.default_route_table_association
  default_route_table_propagation    = var.default_route_table_propagation
  dns_support                        = var.dns_support
  multicast_support                  = var.multicast_support
  vpn_ecmp_support                   = var.vpn_ecmp_support
  security_group_referencing_support = var.security_group_referencing_support
  transit_gateway_cidr_blocks        = var.transit_gateway_cidr_blocks
  vpc_attachments                    = var.vpc_attachments
  tgw_route_cidr_block               = var.tgw_route_cidr_block
  tags                               = var.tags
  transit_gateway_name               = var.transit_gateway_name
}
