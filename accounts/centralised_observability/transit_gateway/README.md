## Terraform AWS TGW Module

<!-- BEGIN_AUTOMATED_TF_DOCS_BLOCK -->
## Provider Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.12.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 5.0 |

## Terraform Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_transit_gateway"></a> [transit\_gateway](#module\_transit\_gateway) | github.com/OT-CLOUD-KIT/terraform-aws-vpc-transit-gateway.git// | v1.0.0 |

## Terraform Resources

| Name | Type |
|------|------|
| [terraform_remote_state.network](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |

## Variable Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_vpc_attachments"></a> [vpc\_attachments](#input\_vpc\_attachments) | List of VPC attachments for the Transit Gateway | <pre>list(object({<br/>    name                           = string<br/>    vpc_id                         = string<br/>    subnet_ids                     = list(string)<br/>    route_table_id                 = optional(string)<br/>    dns_support                    = string<br/>    ipv6_support                   = string<br/>    associate_with_tgw_route_table = bool<br/>    propagate_to_tgw_route_table   = bool<br/>  }))</pre> | n/a | yes |
| <a name="input_amazon_side_asn"></a> [amazon\_side\_asn](#input\_amazon\_side\_asn) | Private Autonomous System Number (ASN) for the Transit Gateway | `number` | `4200000000` | no |
| <a name="input_auto_accept_shared_attachments"></a> [auto\_accept\_shared\_attachments](#input\_auto\_accept\_shared\_attachments) | Whether to automatically accept cross-account attachments | `string` | `"enable"` | no |
| <a name="input_default_route_table_association"></a> [default\_route\_table\_association](#input\_default\_route\_table\_association) | Whether to enable default route table association | `string` | `"enable"` | no |
| <a name="input_default_route_table_propagation"></a> [default\_route\_table\_propagation](#input\_default\_route\_table\_propagation) | Whether to enable default route table propagation | `string` | `"enable"` | no |
| <a name="input_dns_support"></a> [dns\_support](#input\_dns\_support) | Whether to enable DNS support | `string` | `"enable"` | no |
| <a name="input_multicast_support"></a> [multicast\_support](#input\_multicast\_support) | Whether to enable multicast support | `string` | `"disable"` | no |
| <a name="input_region"></a> [region](#input\_region) | AWS region where the Transit Gateway will be created | `string` | `"ap-south-1"` | no |
| <a name="input_security_group_referencing_support"></a> [security\_group\_referencing\_support](#input\_security\_group\_referencing\_support) | Whether to enable security group referencing support | `string` | `"disable"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to add to all resources | `map(string)` | <pre>{<br/>  "Component": "transit-gateway",<br/>  "Environment": "stage",<br/>  "ManagedBy": "Terraform",<br/>  "Organization": "FCI-CCM",<br/>  "Project": "Observability",<br/>  "ResourceType": "transit-gateway",<br/>  "Service": "observability",<br/>  "TerraformState": "observability-terraform-states/observability/transit-gateway.tfstate"<br/>}</pre> | no |
| <a name="input_tgw_description"></a> [tgw\_description](#input\_tgw\_description) | Description of the Transit Gateway | `string` | `"Centralized TGW for observability stage environment"` | no |
| <a name="input_tgw_route_cidr_block"></a> [tgw\_route\_cidr\_block](#input\_tgw\_route\_cidr\_block) | CIDR block for Transit Gateway routes | `string` | `"10.0.0.0/8"` | no |
| <a name="input_transit_gateway_cidr_blocks"></a> [transit\_gateway\_cidr\_blocks](#input\_transit\_gateway\_cidr\_blocks) | List of CIDR blocks for the Transit Gateway | `list(string)` | <pre>[<br/>  "10.250.0.0/16"<br/>]</pre> | no |
| <a name="input_transit_gateway_name"></a> [transit\_gateway\_name](#input\_transit\_gateway\_name) | Name tag for the Transit Gateway | `string` | `"observability-stage-tgw"` | no |
| <a name="input_vpn_ecmp_support"></a> [vpn\_ecmp\_support](#input\_vpn\_ecmp\_support) | Whether to enable VPN ECMP support | `string` | `"enable"` | no |

## Variable Outputs

| Name | Description |
|------|-------------|
| <a name="output_transit_gateway_id"></a> [transit\_gateway\_id](#output\_transit\_gateway\_id) | ID of the Transit Gateway |
| <a name="output_vpc_attachment_ids"></a> [vpc\_attachment\_ids](#output\_vpc\_attachment\_ids) | List of VPC attachment IDs associated with the Transit Gateway |
<!-- END_AUTOMATED_TF_DOCS_BLOCK -->
