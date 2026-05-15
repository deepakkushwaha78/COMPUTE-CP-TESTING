# ------------------
# MODULE: modules/transit-gateway/main.tf
# ------------------

resource "aws_ec2_transit_gateway" "this" {
  description                          = var.description
  amazon_side_asn                     = var.amazon_side_asn
  auto_accept_shared_attachments      = var.auto_accept_shared_attachments
  default_route_table_association     = var.default_route_table_association
  default_route_table_propagation     = var.default_route_table_propagation
  dns_support                         = var.dns_support
  multicast_support                   = var.multicast_support
  vpn_ecmp_support                    = var.vpn_ecmp_support
  security_group_referencing_support = var.security_group_referencing_support
  transit_gateway_cidr_blocks         = var.transit_gateway_cidr_blocks

  tags = merge(
    var.tags,
    {
      Name = var.transit_gateway_name
    }
  )
}

resource "aws_ec2_transit_gateway_vpc_attachment" "this" {
  for_each = { for vpc in var.vpc_attachments : vpc.name => vpc }

  subnet_ids         = each.value.subnet_ids
  transit_gateway_id = aws_ec2_transit_gateway.this.id
  vpc_id             = each.value.vpc_id

  dns_support                            = each.value.dns_support
  ipv6_support                           = each.value.ipv6_support
  transit_gateway_default_route_table_association = each.value.associate_with_tgw_route_table
  transit_gateway_default_route_table_propagation = each.value.propagate_to_tgw_route_table

  tags = merge(var.tags, {
    Name = each.value.name
  })
}

resource "aws_route" "tgw_routes" {
  for_each = { for vpc in var.vpc_attachments : vpc.name => vpc if vpc.route_table_id != null }

  route_table_id         = each.value.route_table_id
  destination_cidr_block = var.tgw_route_cidr_block
  transit_gateway_id     = aws_ec2_transit_gateway.this.id

  # Ensures TGW and all attachments are created before adding the route
  depends_on = [
    aws_ec2_transit_gateway.this,
    aws_ec2_transit_gateway_vpc_attachment.this
  ]
}
