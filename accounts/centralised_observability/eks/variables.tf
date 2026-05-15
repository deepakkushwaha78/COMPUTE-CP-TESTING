variable "eks_api_port" {
  description = "Port for EKS API server access from jumphost"
  type        = number
  default     = 443
}

variable "oidc_client_id" {
  description = "Client ID for the OIDC provider"
  type        = string
  default     = "sts.amazonaws.com"
}

variable "node_sg_https_port" {
  description = "Port for node group SG ingress from cluster SG"
  type        = number
  default     = 443
}

variable "node_sg_protocol" {
  description = "Protocol for node group and cluster SG rules"
  type        = string
  default     = "tcp"
}

variable "ebs_device_name" {
  description = "EBS device name for launch template"
  type        = string
  default     = "/dev/xvda"
}

variable "ebs_volume_type" {
  description = "EBS volume type for node group launch template"
  type        = string
  default     = "gp3"
}

variable "associate_public_ip" {
  description = "Associate public IP with node group instances"
  type        = bool
  default     = false
}

variable "provisioner_tag" {
  description = "Value for the Provisioner tag on EKS addons"
  type        = string
  default     = "Terraform"
}

variable "roles" {
  description = "List of IAM roles to create for EKS cluster and node groups"
  type = list(object({
    name          = string
    assume_policy = string
  }))
}

variable "env" {
  description = "Environment name (e.g., stage, prod, dev)"
  type = string
}

variable "cluster_version" {
  description = "Kubernetes version for the EKS cluster"
  type = string
}

variable "node_image_id" {
  description = "AMI ID for the EKS worker nodes"
  type = string
}

variable "cluster_policy" {
  description = "List of IAM policy ARNs to attach to the EKS cluster role"
  type = list(string)
}

variable "node_policy" {
  description = "List of IAM policy ARNs to attach to the EKS node group role"
  type = list(string)
}

variable "cluster_name" {
  description = "Name of the EKS cluster"
  type = string
}

variable "node_groups" {
  description = "Configuration for EKS node groups"
  type = list(object({
    name               = string
    instance_type      = string
    volume_size        = number
    desired_size       = number
    max_size           = number
    min_size           = number
    labels             = map(string)
    capacity_type      = string
    kubelet_extra_args = string
    tag_name           = string
    node_instance_tags = map(string)
    node_volume_tags   = map(string)
    taint = list(object({
      key    = string
      value  = string
      effect = string
    }))
  }))
}

variable "eks_ingress" {
  description = "A list of ingress rules for EKS cluster security group"
  type = list(object({
    description = string
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
}

variable "eks_egress" {
  description = "A list of egress rules for EKS cluster security group"
  type = list(object({
    description      = string
    from_port        = number
    to_port          = number
    protocol         = string
    cidr_blocks      = list(string)
    ipv6_cidr_blocks = list(string)
  }))
}

variable "enable_public_endpoint" {
  description = "Enable or disable public endpoint access for the EKS cluster"
  type        = bool
  default     = false
}

variable "authentication_mode" {
  description = "Enable or disable ConfigMap for API access"
  type        = bool
  default     = true
}

##########Autoscaler-Variables############
variable "enable_cluster_autoscaler" {
  description = "Enable or disable the EKS Cluster Autoscaler"
  type        = bool
  default     = true
}

variable "aws_region" {
  description = "The AWS region to deploy resources"
  type        = string
  default     = "ap-south-1"
}

variable "node_role" {
  description = "Name of the IAM role for EKS node groups"
  type    = string
  default = "eksnodegroup_role"
}

#### variablizing the name first by nitin ####
variable "org_name" {
  description = "The short name of the organization (e.g., acme)"
  type        = string
}

variable "project_name" {
  description = "The name of the project (e.g., observability)"
  type        = string
}

variable "common_tags" {
  description = "Tags that should be applied to all resources"
  type        = map(string)
  default     = {}
}
variable "environment" {
  type        = string
  description = "Env name (e.g., prod, dev, stage)"
}

variable "eks_addons_map" {
  type = map(string)
  default = {
    "vpc-cni"            = "v1.19.2-eksbuild.1"
    "kube-proxy"         = "v1.33.0-eksbuild.2"
    "coredns"            = "v1.12.1-eksbuild.2"
    "aws-ebs-csi-driver" = "v1.43.0-eksbuild.1"
  }
}