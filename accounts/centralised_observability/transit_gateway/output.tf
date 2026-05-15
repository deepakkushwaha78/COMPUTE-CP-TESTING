output "transit_gateway_id" {
  description = "ID of the Transit Gateway"
  value = module.transit_gateway.transit_gateway_id
}

output "vpc_attachment_ids" {
  description = "List of VPC attachment IDs associated with the Transit Gateway"
  value = module.transit_gateway.vpc_attachment_ids
}
