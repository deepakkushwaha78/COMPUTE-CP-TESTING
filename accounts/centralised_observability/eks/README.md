## Terraform AWS EKS Module

<!-- BEGIN_AUTOMATED_TF_DOCS_BLOCK -->
## Provider Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.12.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | 5.100.0 |

## Terraform Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_eks"></a> [eks](#module\_eks) | github.com/OT-CLOUD-KIT/terraform-aws-eks.git// | v1.2.0 |
| <a name="module_iam"></a> [iam](#module\_iam) | github.com/OT-CLOUD-KIT/terraform-aws-iam.git// | v2 |

## Terraform Resources

| Name | Type |
|------|------|
| [terraform_remote_state.network](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |

## Variable Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | Name of the EKS cluster | `string` | n/a | yes |
| <a name="input_cluster_policy"></a> [cluster\_policy](#input\_cluster\_policy) | List of IAM policy ARNs to attach to the EKS cluster role | `list(string)` | n/a | yes |
| <a name="input_cluster_version"></a> [cluster\_version](#input\_cluster\_version) | Kubernetes version for the EKS cluster | `string` | n/a | yes |
| <a name="input_eks_addons"></a> [eks\_addons](#input\_eks\_addons) | List of EKS addons to install | <pre>list(object({<br/>    name    = string<br/>    version = string<br/>  }))</pre> | n/a | yes |
| <a name="input_eks_egress"></a> [eks\_egress](#input\_eks\_egress) | A list of egress rules for EKS cluster security group | <pre>list(object({<br/>    description      = string<br/>    from_port        = number<br/>    to_port          = number<br/>    protocol         = string<br/>    cidr_blocks      = list(string)<br/>    ipv6_cidr_blocks = list(string)<br/>  }))</pre> | n/a | yes |
| <a name="input_eks_ingress"></a> [eks\_ingress](#input\_eks\_ingress) | A list of ingress rules for EKS cluster security group | <pre>list(object({<br/>    description = string<br/>    from_port   = number<br/>    to_port     = number<br/>    protocol    = string<br/>    cidr_blocks = list(string)<br/>  }))</pre> | n/a | yes |
| <a name="input_env"></a> [env](#input\_env) | Environment name (e.g., stage, prod, dev) | `string` | n/a | yes |
| <a name="input_node_groups"></a> [node\_groups](#input\_node\_groups) | Configuration for EKS node groups | <pre>list(object({<br/>    name               = string<br/>    instance_type      = string<br/>    volume_size        = number<br/>    desired_size       = number<br/>    max_size           = number<br/>    min_size           = number<br/>    labels             = map(string)<br/>    capacity_type      = string<br/>    kubelet_extra_args = string<br/>    tag_name           = string<br/>    node_instance_tags = map(string)<br/>    node_volume_tags   = map(string)<br/>    taint = list(object({<br/>      key    = string<br/>      value  = string<br/>      effect = string<br/>    }))<br/>  }))</pre> | n/a | yes |
| <a name="input_node_image_id"></a> [node\_image\_id](#input\_node\_image\_id) | AMI ID for the EKS worker nodes | `string` | n/a | yes |
| <a name="input_node_policy"></a> [node\_policy](#input\_node\_policy) | List of IAM policy ARNs to attach to the EKS node group role | `list(string)` | n/a | yes |
| <a name="input_roles"></a> [roles](#input\_roles) | List of IAM roles to create for EKS cluster and node groups | <pre>list(object({<br/>    name          = string<br/>    assume_policy = string<br/>  }))</pre> | n/a | yes |
| <a name="input_authentication_mode"></a> [authentication\_mode](#input\_authentication\_mode) | Enable or disable ConfigMap for API access | `bool` | `true` | no |
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | The AWS region to deploy resources | `string` | `"ap-south-1"` | no |
| <a name="input_enable_cluster_autoscaler"></a> [enable\_cluster\_autoscaler](#input\_enable\_cluster\_autoscaler) | Enable or disable the EKS Cluster Autoscaler | `bool` | `true` | no |
| <a name="input_enable_public_endpoint"></a> [enable\_public\_endpoint](#input\_enable\_public\_endpoint) | Enable or disable public endpoint access for the EKS cluster | `bool` | `false` | no |
| <a name="input_node_role"></a> [node\_role](#input\_node\_role) | Name of the IAM role for EKS node groups | `string` | `"eksnodegroup_role"` | no |

## Variable Outputs

| Name | Description |
|------|-------------|
| <a name="output_eks_cluster_endpoint"></a> [eks\_cluster\_endpoint](#output\_eks\_cluster\_endpoint) | The endpoint of the EKS cluster. |
| <a name="output_eks_cluster_name"></a> [eks\_cluster\_name](#output\_eks\_cluster\_name) | The endpoint of the EKS cluster. |
| <a name="output_node_group_role_arn"></a> [node\_group\_role\_arn](#output\_node\_group\_role\_arn) | ARN of the IAM role associated with the EKS node group. |
<!-- END_AUTOMATED_TF_DOCS_BLOCK -->
