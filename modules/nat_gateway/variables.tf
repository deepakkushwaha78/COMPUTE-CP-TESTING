variable "subnets_for_nat_gw" {
  type = list(string)
}

variable "nat_name" {
  description = "Name of VPC in which NAT will be created"
  type        = string
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}
