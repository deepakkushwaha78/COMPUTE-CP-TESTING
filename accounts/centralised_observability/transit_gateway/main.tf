module "transit_gateway" {
  source = "../../../modules/transit_gateway"

# Naming & Description
  transit_gateway_name = "${local.resource_prefix}-tgw"
  description          = "TGW for ${var.org_name} ${var.environment}"
  #description                        = var.tgw_description
  amazon_side_asn                    = var.amazon_side_asn
  auto_accept_shared_attachments     = var.auto_accept_shared_attachments
  default_route_table_association    = var.default_route_table_association
  default_route_table_propagation    = var.default_route_table_propagation
  dns_support                        = var.dns_support
  multicast_support                  = var.multicast_support
  vpn_ecmp_support                   = var.vpn_ecmp_support
  security_group_referencing_support = var.security_group_referencing_support
  transit_gateway_cidr_blocks        = var.transit_gateway_cidr_blocks
  #{
  #vpc_attachments = [
  #  name                           = "observability-tgw-attach"
  #  vpc_id                         = data.terraform_remote_state.network.outputs.vpc_id
  #  subnet_ids                     = data.terraform_remote_state.network.outputs.pvt_subnet_ids[0]
  #  route_table_id                 = data.terraform_remote_state.network.outputs.pvt_route_table_id
  #  dns_support                    = "enable"
  #  ipv6_support                   = "disable"
  #  associate_with_tgw_route_table = true
  #  propagate_to_tgw_route_table   = true
  #}
#]
vpc_attachments = var.vpc_attachments

  tgw_route_cidr_block               = var.tgw_route_cidr_block
  #tags                               = var.tags
  # Automated Tagging
  tags = merge(local.standard_tags, {
    "ResourceType" = "transit-gateway"
    "Component"    = "networking-hub"
  })
  #transit_gateway_name               = var.transit_gateway_name
}
