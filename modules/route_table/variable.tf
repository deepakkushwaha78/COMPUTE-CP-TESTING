variable "vpc_id" {}

variable "name" {
  description = "Name of Route Table To be created "
  type        = string
}

variable "gateway_id" {}

variable "cidr" {
  description = "CIDR to which traffic will be allowed"
  type        = string
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}
