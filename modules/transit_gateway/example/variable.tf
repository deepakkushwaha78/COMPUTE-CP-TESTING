variable "description" {
  type = string
}

variable "amazon_side_asn" {
  type = number
}

variable "auto_accept_shared_attachments" {
  type = string
}

variable "default_route_table_association" {
  type = string
}

variable "default_route_table_propagation" {
  type = string
}

variable "dns_support" {
  type = string
}

variable "multicast_support" {
  type = string
}

variable "vpn_ecmp_support" {
  type = string
}

variable "security_group_referencing_support" {
  type = string
}

variable "transit_gateway_cidr_blocks" {
  type = list(string)
}

variable "tags" {
  type = map(string)
}

variable "vpc_attachments" {
  type = list(object({
    name                           = string
    vpc_id                         = string
    subnet_ids                     = list(string)
    route_table_id                 = optional(string)
    dns_support                    = string
    ipv6_support                   = string
    associate_with_tgw_route_table = bool
    propagate_to_tgw_route_table   = bool
  }))
}

variable "tgw_route_cidr_block" {
  type = string
}

variable "transit_gateway_name" {
  description = "Name tag for the Transit Gateway"
  type        = string
}