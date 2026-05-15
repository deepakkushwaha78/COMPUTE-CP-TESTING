# region          = "ap-south-1"
cluster_name    = "observability-eks"
cluster_version = "1.33"
env             = "observability"

# GLOBAL IDENTITY
org_name     = "nitin-labs"
project_name = "monitoring"

common_tags = {
  "Organization" = "nitin-labs"
  "ManagedBy"    = "terraform"
  "Environment"  = "production"
}

# IAM Roles and Policies
roles = [
  {
    name          = "observability-cluster-role"
    assume_policy = "./policies/cluster/eks_cluster_assume_policy.json"
  },
  {
    name          = "observability-nodegroup-role"
    assume_policy = "./policies/nodegroup/eks_node_group_assume_policy.json"
  }
]

cluster_policy = [
  "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy",
  "arn:aws:iam::aws:policy/AmazonEKSVPCResourceController"
]

node_policy = [
  "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy",
  "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly",
  "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy",
  "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore",
  "arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy"
]

# node_image_id = "ami-003c0d8931dc3f095" #amd64
node_image_id = "ami-003c0d8931dc3f095" #amd64

# Node Groups Configuration
node_groups = [
  {
    name = "observability-worker-nodes"
    # instance_type = "c6a.4xlarge"
    instance_type = "t3.small"
    volume_size   = 20
    desired_size  = 2
    max_size      = 2
    min_size      = 2
    # user_data     = "./policies/userdata/observability-nodegroup-userdata.sh"
    labels = {
      "observability--worker" = "enabled"
    }
    taint = [
      {
        key    = "observability-worker"
        value  = "enabled"
        effect = "NO_SCHEDULE"
      }
    ]
    capacity_type      = "SPOT"
    kubelet_extra_args = "--max-pods=20 --node-labels=observability-worker=enabled"
    taint              = []
    tag_name           = "observability-"
    # Let the main.tf merge logic handle these!
    node_instance_tags = {} 
    node_volume_tags   = {}
  }
]

# EKS Addons
#eks_addons = [
 # { name = "vpc-cni", version = "v1.19.2-eksbuild.1" },
  #{ name = "kube-proxy", version = "v1.33.0-eksbuild.2" },
  #{ name = "coredns", version = "v1.12.1-eksbuild.2" },
  #{ name = "aws-ebs-csi-driver", version = "v1.43.0-eksbuild.1" }
#]


eks_addons_map = {
    "vpc-cni"            = "v1.19.2-eksbuild.1" # Only change what you need
    "kube-proxy"         = "v1.33.0-eksbuild.2"
    "coredns"            = "v1.12.1-eksbuild.2"
    "aws-ebs-csi-driver" = "v1.43.0-eksbuild.1"
}

# Security Group Rules
eks_ingress = [
  {
    description = "Allow HTTP traffic"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  },
  {
    description = "Allow HTTPS traffic"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
]

eks_egress = [
  {
    description      = "Allow all outbound traffic"
    from_port        = 0
    to_port          = 0
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = []
  }
]

# Cluster Configuration
enable_public_endpoint = false
authentication_mode    = true

# EKS Hardcoded Defaults
eks_api_port        = 443
oidc_client_id      = "sts.amazonaws.com"
node_sg_https_port  = 443
node_sg_protocol    = "tcp"
ebs_device_name     = "/dev/xvda"
ebs_volume_type     = "gp3"
associate_public_ip = false
provisioner_tag     = "Terraform"
