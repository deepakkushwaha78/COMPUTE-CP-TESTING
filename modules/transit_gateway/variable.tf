variable "description" {
  type        = string
  description = "Transit Gateway description"
}

variable "amazon_side_asn" {
  type        = number
  description = "The ASN for the Amazon side of a BGP session"
}

variable "auto_accept_shared_attachments" {
  type        = string
  description = "Auto accept shared attachments - enable/disable"
  default     = "enable"
}

variable "default_route_table_association" {
  type        = string
  description = "Enable default route table association"
  default     = "enable"
}

variable "default_route_table_propagation" {
  type        = string
  description = "Enable default route table propagation"
  default     = "enable"
}

variable "dns_support" {
  type        = string
  description = "Enable/Disable DNS support"
  default     = "enable"
}

variable "multicast_support" {
  type        = string
  description = "Enable/Disable multicast support"
  default     = "disable"
}

variable "vpn_ecmp_support" {
  type        = string
  description = "Enable/Disable Equal Cost Multipath support"
  default     = "enable"
}

variable "security_group_referencing_support" {
  type        = string
  description = "Enable/Disable SG referencing"
  default     = "disable"
}

variable "transit_gateway_cidr_blocks" {
  type        = list(string)
  description = "Optional IPv4 CIDR blocks"
  default     = []
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply to all resources"
  default     = {}
}

variable "vpc_attachments" {
  type = list(object({
    name                             = string
    vpc_id                           = string
    subnet_ids                       = list(string)
    route_table_id                   = optional(string)
    dns_support                      = string
    ipv6_support                     = string
    associate_with_tgw_route_table  = bool
    propagate_to_tgw_route_table    = bool
  }))
  description = "List of VPCs to attach to the TGW"
}

variable "tgw_route_cidr_block" {
  type        = string
  description = "CIDR block for route entries"
}

variable "transit_gateway_name" {
  type        = string
  description = "Name tag for the Transit Gateway"
}
