output "vpc_id" {
  description = "ID of the VPC"
  value       = module.network_skeleton.vpc_id
}

output "pvt_subnet_ids" {
  description = "List of private subnet IDs"
  value       = module.network_skeleton.pvt_subnet_ids
}

output "pvt_route_table_id" {
  description = "Private route table id"
  value       = module.network_skeleton.pvt_route_table_id
}

output "pub_subnet_ids" {
  description = "List of public subnet IDs"
  value       = module.network_skeleton.public_subnet_ids
}

output "alb_httplistener_arn" {
  description = "ARN of the HTTP listener for the Application Load Balancer"
  value       = module.network_skeleton.alb_listener_arn
}

output "alb_httpslistener_arn" {
  description = "ARN of the HTTPS listener for the Application Load Balancer"
  value       = module.network_skeleton.alb_listener1_arn
}

output "s3_bucket_id" {
  description = "The name of the bucket."
  value       = try(module.aws_s3_bucket.s3_bucket_id, "")
}

output "s3_bucket_arn" {
  description = "The ARN of the bucket. Will be of format arn:aws:s3:::bucketname."
  value       = try(module.aws_s3_bucket.s3_bucket_arn, "")
}

output "s3_bucket_bucket_domain_name" {
  description = "The bucket domain name. Will be of format bucketname.s3.amazonaws.com."
  value       = try(module.aws_s3_bucket.s3_bucket_bucket_domain_name, "")
}

output "s3_bucket_region" {
  description = "The AWS region this bucket resides in."
  value       = try(module.aws_s3_bucket.s3_bucket_region, "")
}

output "id" {
  description = "The name of the bucket."
  value       = try(module.aws_s3_bucket.id, "")
}

output "arn" {
  description = "The ARN of the bucket. Will be of format arn:aws:s3:::bucketname."
  value       = try(module.aws_s3_bucket.arn, "")
}

output "name" {
  description = "The bucket domain name. Will be of format bucketname.s3.amazonaws.com."
  value       = try(module.aws_s3_bucket.name, "")
}

output "jumphost_sg_id" {
  description = "ID of the jumphost security group"
  value       = module.jumphost_security_group.sg_id
}
output "jumphost_instance_id" {
  description = "ID of the jumphost EC2 instance"
  value       = module.jumphost_server.instance_id
}

output "jumphost_instance_private_ip" {
  description = "Private IP address of the jumphost server"
  value       = module.jumphost_server.private_ip
}

output "jumphost_key_pair_name" {
  description = "Name of the key pair used for jumphost"
  value       = aws_key_pair.jumphost_pem.key_name
}
