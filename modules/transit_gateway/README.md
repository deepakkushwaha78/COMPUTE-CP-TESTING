## Terraform AWS Transit-gateway

This module creates a Transit Gateway (TGW) and allows you to attach multiple VPCs with customizable route propagation and association settings.

## Architecture
![image](https://github.com/user-attachments/assets/528b2538-7f71-4fa9-b54e-a280729d4435)

## Providers

| Name                                              | Version  |
|---------------------------------------------------|----------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.12.1 |

## Usage 

 ```hcl
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
```

## Resources

| Name                                                  | Type      |
|-------------------------------------------------------|-----------|
| `aws_ec2_transit_gateway`                             | Resource  |
| `aws_ec2_transit_gateway_vpc_attachment`              | Resource  |
| `aws_ec2_transit_gateway_route`                       | Resource  |
| `aws_ec2_transit_gateway_route_table`                 | Resource  |
| `aws_ec2_transit_gateway_route_table_association`     | Resource  |
| `aws_ec2_transit_gateway_route_table_propagation`     | Resource  |

---

## Inputs

| Name                              | Description                                           | Type             | Default     | Required |
|-----------------------------------|-------------------------------------------------------|------------------|-------------|----------|
| `transit_gateway_name`            | Name tag for the Transit Gateway                     | `string`         | `"tgw"`     | yes      |
| `description`                     | Description of the TGW                               | `string`         | `""`        | no       |
| `amazon_side_asn`                | ASN for Amazon side of the TGW                       | `number`         | `64512`     | yes      |
| `auto_accept_shared_attachments` | Auto-accept cross-account attachments                | `string`         | `"disable"` | no       |
| `default_route_table_association`| Enable default route table association               | `string`         | `"enable"`  | no       |
| `default_route_table_propagation`| Enable default route table propagation               | `string`         | `"enable"`  | no       |
| `dns_support`                    | Enable DNS support for TGW                           | `string`         | `"enable"`  | no       |
| `multicast_support`              | Enable multicast support                             | `string`         | `"disable"` | no       |
| `vpn_ecmp_support`               | Enable ECMP for VPN                                  | `string`         | `"enable"`  | no       |
| `security_group_referencing_support` | Enable SG referencing across VPCs               | `string`         | `"disable"` | no       |
| `transit_gateway_cidr_blocks`    | List of CIDR blocks for the TGW                      | `list(string)`   | `[]`        | no       |
| `tgw_route_cidr_block`           | CIDR to add route to in each VPC                     | `string`         | `""`        | yes      |
| `tags`                           | Tags to apply to TGW and attachments                 | `map(string)`    | `{}`        | no       |
| `vpc_attachments`                | VPCs to attach with options                          | `list(object)`   | `[]`        | yes      |


## Outputs

| Name                  | Description                                              |
|-----------------------|----------------------------------------------------------|
| `transit_gateway_id`  | The ID of the created Transit Gateway                    |
| `vpc_attachment_ids`  | A map of VPC attachment names to their TGW attachment IDs |

---

## Considerations

- Ensure VPCs, subnets, and route tables exist **before applying** this module.
- Validate that **subnet IDs are correct** and belong to the specified VPC.
- This module supports **advanced routing** using TGW route table associations and propagations.
