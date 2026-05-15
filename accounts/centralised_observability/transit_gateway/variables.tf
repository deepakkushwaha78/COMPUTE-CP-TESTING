variable "region" {
  description = "AWS region where the Transit Gateway will be created"
  type        = string
  default     = "ap-south-1"
}


variable "tgw_description" {
  description = "Description of the Transit Gateway"
  type        = string
  default     = "Centralized TGW for observability stage environment"
}

variable "amazon_side_asn" {
  description = "Private Autonomous System Number (ASN) for the Transit Gateway"
  type        = number
  default     = 4200000000
}

variable "auto_accept_shared_attachments" {
  description = "Whether to automatically accept cross-account attachments"
  type        = string
  default     = "enable"
  validation {
    condition     = contains(["enable", "disable"], var.auto_accept_shared_attachments)
    error_message = "Value must be either 'enable' or 'disable'."
  }
}

variable "default_route_table_association" {
  description = "Whether to enable default route table association"
  type        = string
  default     = "enable"
  validation {
    condition     = contains(["enable", "disable"], var.default_route_table_association)
    error_message = "Value must be either 'enable' or 'disable'."
  }
}

variable "default_route_table_propagation" {
  description = "Whether to enable default route table propagation"
  type        = string
  default     = "enable"
  validation {
    condition     = contains(["enable", "disable"], var.default_route_table_propagation)
    error_message = "Value must be either 'enable' or 'disable'."
  }
}

variable "dns_support" {
  description = "Whether to enable DNS support"
  type        = string
  default     = "enable"
  validation {
    condition     = contains(["enable", "disable"], var.dns_support)
    error_message = "Value must be either 'enable' or 'disable'."
  }
}

variable "multicast_support" {
  description = "Whether to enable multicast support"
  type        = string
  default     = "disable"
  validation {
    condition     = contains(["enable", "disable"], var.multicast_support)
    error_message = "Value must be either 'enable' or 'disable'."
  }
}

variable "vpn_ecmp_support" {
  description = "Whether to enable VPN ECMP support"
  type        = string
  default     = "enable"
  validation {
    condition     = contains(["enable", "disable"], var.vpn_ecmp_support)
    error_message = "Value must be either 'enable' or 'disable'."
  }
}

variable "security_group_referencing_support" {
  description = "Whether to enable security group referencing support"
  type        = string
  default     = "disable"
  validation {
    condition     = contains(["enable", "disable"], var.security_group_referencing_support)
    error_message = "Value must be either 'enable' or 'disable'."
  }
}

variable "transit_gateway_cidr_blocks" {
  description = "List of CIDR blocks for the Transit Gateway"
  type        = list(string)
  default     = ["10.250.0.0/16"]
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default = {
    Organization   = "FCI-CCM"
    ManagedBy      = "Terraform"
    Project        = "Observability"
    Environment    = "stage"
    Service        = "observability"
    Component      = "transit-gateway"
    ResourceType   = "transit-gateway"
    TerraformState = "observability-terraform-states/observability/transit-gateway.tfstate"
  }
}

variable "vpc_attachments" {
  description = "List of VPC attachments for the Transit Gateway"
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
  validation {
    condition     = alltrue([for attachment in var.vpc_attachments : contains(["enable", "disable"], attachment.dns_support)])
    error_message = "dns_support must be either 'enable' or 'disable' for all attachments."
  }
  validation {
    condition     = alltrue([for attachment in var.vpc_attachments : contains(["enable", "disable"], attachment.ipv6_support)])
    error_message = "ipv6_support must be either 'enable' or 'disable' for all attachments."
  }
}

variable "tgw_route_cidr_block" {
  description = "CIDR block for Transit Gateway routes"
  type        = string
  default     = "10.0.0.0/8"
}

variable "transit_gateway_name" {
  description = "Name tag for the Transit Gateway"
  type        = string
  default     = "observability-stage-tgw"
}

# --- IDENTITY ---
variable "org_name" {}
variable "project_name" {}
variable "environment" {}