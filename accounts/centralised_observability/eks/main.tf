module "iam" {
  source         = "../../../modules/iam"
  roles          = var.roles
  cluster_policy = var.cluster_policy
  node_policy    = var.node_policy
}

module "eks" {
  source                    = "../../../modules/eks"
  env                       = var.env
  cluster_version           = var.cluster_version
  vpc_id                    = data.terraform_remote_state.network.outputs.vpc_id
  subnet_ids                = data.terraform_remote_state.network.outputs.pvt_subnet_ids[0]
  cluster_name              = var.cluster_name
  cluster_role              = module.iam.eks-roles[0]

  #node_groups               = var.node_groups
  # AUTOMATED NODE TAGGING
  # This loop injects your dynamic tags into the node_groups variable
  node_groups = [
    for ng in var.node_groups : merge(ng, {
      node_instance_tags = merge(local.standard_tags, { 
        "ResourceType" = "nodegroup",
        "Component"    = "worker-node" 
      })
      node_volume_tags   = merge(local.standard_tags, { 
        "ResourceType" = "ebs",
        "Component"    = "storage" 
      })
    })
  ]
  key_pair                  = data.terraform_remote_state.network.outputs.jumphost_key_pair_name
  node_image_id             = var.node_image_id
  node_role                 = module.iam.eks-roles[1]
# eks_addons                = var.eks_addons
# Converting map to the object list your current variable expects:
  eks_addons = [
    for name, version in var.eks_addons_map : {
      name    = name
      version = version
    }
  ]
  eks_ingress               = var.eks_ingress
  eks_egress                = var.eks_egress
  enable_public_endpoint    = var.enable_public_endpoint
  authentication_mode       = var.authentication_mode
  enable_cluster_autoscaler = var.enable_cluster_autoscaler
  aws_region                = var.aws_region
  oidc_client_id            = var.oidc_client_id
  node_sg_https_port        = var.node_sg_https_port
  node_sg_protocol          = var.node_sg_protocol
  ebs_device_name           = var.ebs_device_name
  ebs_volume_type           = var.ebs_volume_type
  associate_public_ip       = var.associate_public_ip
  provisioner_tag           = var.provisioner_tag
  eks_cluster_sg_rules = {
    rule1 = {
      from_port                = var.eks_api_port
      to_port                  = var.eks_api_port
      source_security_group_id = data.terraform_remote_state.network.outputs.jumphost_sg_id
    }
  }
}
