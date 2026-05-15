## Terraform AWS Network Skeleton Module

<!-- BEGIN_AUTOMATED_TF_DOCS_BLOCK -->
## Provider Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.12.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | 5.100.0 |

## Terraform Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_aws_s3_bucket"></a> [aws\_s3\_bucket](#module\_aws\_s3\_bucket) | github.com/OT-CLOUD-KIT/terraform-aws-s3.github.io// | v1.0.0 |
| <a name="module_jumphost_security_group"></a> [jumphost\_security\_group](#module\_jumphost\_security\_group) | github.com/OT-CLOUD-KIT/terraform-aws-security-groups.git// | v.0.0.4 |
| <a name="module_jumphost_server"></a> [jumphost\_server](#module\_jumphost\_server) | github.com/OT-CLOUD-KIT/terraform-aws-ec2-instance.git// | v0.0.3 |
| <a name="module_network_skeleton"></a> [network\_skeleton](#module\_network\_skeleton) | github.com/OT-CLOUD-KIT/terraform-aws-network-skeleton.git// | v1.0.0 |

## Variable Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_alb_name"></a> [alb\_name](#input\_alb\_name) | Name of the Application Load Balancer | `string` | n/a | yes |
| <a name="input_ami_id"></a> [ami\_id](#input\_ami\_id) | AMI ID for the jumphost server | `string` | n/a | yes |
| <a name="input_cidr_block"></a> [cidr\_block](#input\_cidr\_block) | CIDR block for the VPC | `string` | n/a | yes |
| <a name="input_igw_name"></a> [igw\_name](#input\_igw\_name) | Name of the Internet Gateway | `string` | n/a | yes |
| <a name="input_jumphost_public_key"></a> [jumphost\_public\_key](#input\_jumphost\_public\_key) | Public key for the jumphost key pair | `string` | n/a | yes |
| <a name="input_jumphost_tags"></a> [jumphost\_tags](#input\_jumphost\_tags) | Tags to be applied to all resources | `map(string)` | n/a | yes |
| <a name="input_logs_bucket"></a> [logs\_bucket](#input\_logs\_bucket) | S3 bucket for VPC flow logs | `string` | n/a | yes |
| <a name="input_nat_name"></a> [nat\_name](#input\_nat\_name) | Name of the NAT Gateway | `string` | n/a | yes |
| <a name="input_pub_rt_name"></a> [pub\_rt\_name](#input\_pub\_rt\_name) | Name of the public route table | `string` | n/a | yes |
| <a name="input_pub_subnet_name"></a> [pub\_subnet\_name](#input\_pub\_subnet\_name) | Names of public subnets | `list(string)` | n/a | yes |
| <a name="input_public_web_sg_cidr_80_port"></a> [public\_web\_sg\_cidr\_80\_port](#input\_public\_web\_sg\_cidr\_80\_port) | CIDR blocks allowed to access port 80 | `list(string)` | n/a | yes |
| <a name="input_public_web_sg_name"></a> [public\_web\_sg\_name](#input\_public\_web\_sg\_name) | Name of the public web security group | `string` | n/a | yes |
| <a name="input_pvt_rt_name"></a> [pvt\_rt\_name](#input\_pvt\_rt\_name) | Name of the private route table | `string` | n/a | yes |
| <a name="input_pvt_subnet_name"></a> [pvt\_subnet\_name](#input\_pvt\_subnet\_name) | Names of private subnets | `list(string)` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to apply to all resources | `map(string)` | n/a | yes |
| <a name="input_vpc_name"></a> [vpc\_name](#input\_vpc\_name) | Name of the VPC | `string` | n/a | yes |
| <a name="input_alb_certificate_arn"></a> [alb\_certificate\_arn](#input\_alb\_certificate\_arn) | ARN of the SSL certificate for HTTPS listener | `string` | `""` | no |
| <a name="input_attach_iam_policy"></a> [attach\_iam\_policy](#input\_attach\_iam\_policy) | Controls if S3 bucket should have bucket policy attached (set to `true` to use value of `policy` as bucket policy) | `bool` | `false` | no |
| <a name="input_avaialability_zones"></a> [avaialability\_zones](#input\_avaialability\_zones) | List of availability zones | `list(string)` | <pre>[<br/>  "ap-south-1a",<br/>  "ap-south-1b"<br/>]</pre> | no |
| <a name="input_create_bucket"></a> [create\_bucket](#input\_create\_bucket) | Controls if S3 bucket should be created | `bool` | `true` | no |
| <a name="input_disable_api_termination"></a> [disable\_api\_termination](#input\_disable\_api\_termination) | If true, enables EC2 Instance Termination protection | `bool` | `true` | no |
| <a name="input_ec2_instance_name"></a> [ec2\_instance\_name](#input\_ec2\_instance\_name) | Name of the EC2 instance | `string` | `"jumphost"` | no |
| <a name="input_enable_alb_logging"></a> [enable\_alb\_logging](#input\_enable\_alb\_logging) | Enable ALB access logging | `bool` | `true` | no |
| <a name="input_enable_aws_route53_zone_resource"></a> [enable\_aws\_route53\_zone\_resource](#input\_enable\_aws\_route53\_zone\_resource) | Enable creation of Route53 private hosted zone | `bool` | `true` | no |
| <a name="input_enable_deletion_protection"></a> [enable\_deletion\_protection](#input\_enable\_deletion\_protection) | Enable deletion protection for ALB | `bool` | `false` | no |
| <a name="input_enable_https_listener"></a> [enable\_https\_listener](#input\_enable\_https\_listener) | Enable HTTPS listener on ALB | `bool` | `true` | no |
| <a name="input_enable_igw_publicRouteTable_PublicSubnets_resource"></a> [enable\_igw\_publicRouteTable\_PublicSubnets\_resource](#input\_enable\_igw\_publicRouteTable\_PublicSubnets\_resource) | Enable creation of IGW, public route table and public subnets | `bool` | `true` | no |
| <a name="input_enable_nat_privateRouteTable_PrivateSubnets_resource"></a> [enable\_nat\_privateRouteTable\_PrivateSubnets\_resource](#input\_enable\_nat\_privateRouteTable\_PrivateSubnets\_resource) | Enable creation of NAT Gateway, private route table and private subnets | `bool` | `true` | no |
| <a name="input_enable_pub_alb_resource"></a> [enable\_pub\_alb\_resource](#input\_enable\_pub\_alb\_resource) | This variable is to create ALB | `bool` | `false` | no |
| <a name="input_enable_public_web_security_group_resource"></a> [enable\_public\_web\_security\_group\_resource](#input\_enable\_public\_web\_security\_group\_resource) | This variable is to create Web Security Group | `bool` | `true` | no |
| <a name="input_iam_policy"></a> [iam\_policy](#input\_iam\_policy) | (Optional) A valid bucket policy JSON document. Note that if the policy document is not specific enough (but still valid), Terraform may view the policy as constantly changing in a terraform plan. In this case, please make sure you use the verbose/specific version of the policy. For more information about building AWS IAM policy documents with Terraform, see the AWS IAM Policy Document Guide. | `string` | `null` | no |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | Instance type for the jumphost server | `string` | `"t3a.xlarge"` | no |
| <a name="input_key_name"></a> [key\_name](#input\_key\_name) | Name of the key pair | `string` | `"jumphost-key"` | no |
| <a name="input_logs_bucket_arn"></a> [logs\_bucket\_arn](#input\_logs\_bucket\_arn) | ARN of S3 bucket for VPC flow logs | `string` | `""` | no |
| <a name="input_metric_configuration"></a> [metric\_configuration](#input\_metric\_configuration) | List of maps containing bucket metric configurations. | <pre>list(object({<br/>    id = string<br/>    filter = list(object({<br/>      prefix = string<br/>      tags   = map(string)<br/>    }))<br/>    enabled = bool<br/>    name    = string<br/>  }))</pre> | <pre>[<br/>  {<br/>    "enabled": true,<br/>    "filter": [],<br/>    "id": "metric-1",<br/>    "name": "metric"<br/>  }<br/>]</pre> | no |
| <a name="input_name"></a> [name](#input\_name) | (Optional, Forces new resource) The name of the bucket. If omitted, Terraform will assign a random, unique name. | `string` | `""` | no |
| <a name="input_private_subnets_cidr"></a> [private\_subnets\_cidr](#input\_private\_subnets\_cidr) | CIDR blocks for private subnets | `list(string)` | <pre>[<br/>  "10.250.2.0/23",<br/>  "10.250.4.0/23"<br/>]</pre> | no |
| <a name="input_public_ip"></a> [public\_ip](#input\_public\_ip) | Whether to associate a public IP address with the instance | `bool` | `false` | no |
| <a name="input_public_subnets_cidr"></a> [public\_subnets\_cidr](#input\_public\_subnets\_cidr) | CIDR blocks for public subnets | `list(string)` | <pre>[<br/>  "10.250.0.0/24",<br/>  "10.250.1.0/24"<br/>]</pre> | no |
| <a name="input_pvt_zone_name"></a> [pvt\_zone\_name](#input\_pvt\_zone\_name) | Name of the private hosted zone | `string` | `""` | no |
| <a name="input_region"></a> [region](#input\_region) | AWS region where resources will be created | `string` | `"ap-south-1"` | no |
| <a name="input_security_group_name"></a> [security\_group\_name](#input\_security\_group\_name) | Name of the jumphost security group | `string` | `"jumphost-sg"` | no |
| <a name="input_volume_encrypted"></a> [volume\_encrypted](#input\_volume\_encrypted) | Whether the EBS volume should be encrypted | `bool` | `true` | no |
| <a name="input_volume_size"></a> [volume\_size](#input\_volume\_size) | Size of the EBS volume | `number` | `30` | no |
| <a name="input_volume_type"></a> [volume\_type](#input\_volume\_type) | Type of the EBS volume | `string` | `"gp3"` | no |

## OVariable outputs

| Name | Description |
|------|-------------|
| <a name="output_alb_httplistener_arn"></a> [alb\_httplistener\_arn](#output\_alb\_httplistener\_arn) | ARN of the HTTP listener for the Application Load Balancer |
| <a name="output_alb_httpslistener_arn"></a> [alb\_httpslistener\_arn](#output\_alb\_httpslistener\_arn) | ARN of the HTTPS listener for the Application Load Balancer |
| <a name="output_arn"></a> [arn](#output\_arn) | The ARN of the bucket. Will be of format arn:aws:s3:::bucketname. |
| <a name="output_id"></a> [id](#output\_id) | The name of the bucket. |
| <a name="output_jumphost_instance_id"></a> [jumphost\_instance\_id](#output\_jumphost\_instance\_id) | ID of the jumphost EC2 instance |
| <a name="output_jumphost_instance_private_ip"></a> [jumphost\_instance\_private\_ip](#output\_jumphost\_instance\_private\_ip) | Private IP address of the jumphost server |
| <a name="output_jumphost_key_pair_name"></a> [jumphost\_key\_pair\_name](#output\_jumphost\_key\_pair\_name) | Name of the key pair used for jumphost |
| <a name="output_jumphost_sg_id"></a> [jumphost\_sg\_id](#output\_jumphost\_sg\_id) | ID of the jumphost security group |
| <a name="output_name"></a> [name](#output\_name) | The bucket domain name. Will be of format bucketname.s3.amazonaws.com. |
| <a name="output_pub_subnet_ids"></a> [pub\_subnet\_ids](#output\_pub\_subnet\_ids) | List of public subnet IDs |
| <a name="output_pvt_route_table_id"></a> [pvt\_route\_table\_id](#output\_pvt\_route\_table\_id) | Private route table id |
| <a name="output_pvt_subnet_ids"></a> [pvt\_subnet\_ids](#output\_pvt\_subnet\_ids) | List of private subnet IDs |
| <a name="output_s3_bucket_arn"></a> [s3\_bucket\_arn](#output\_s3\_bucket\_arn) | The ARN of the bucket. Will be of format arn:aws:s3:::bucketname. |
| <a name="output_s3_bucket_bucket_domain_name"></a> [s3\_bucket\_bucket\_domain\_name](#output\_s3\_bucket\_bucket\_domain\_name) | The bucket domain name. Will be of format bucketname.s3.amazonaws.com. |
| <a name="output_s3_bucket_id"></a> [s3\_bucket\_id](#output\_s3\_bucket\_id) | The name of the bucket. |
| <a name="output_s3_bucket_region"></a> [s3\_bucket\_region](#output\_s3\_bucket\_region) | The AWS region this bucket resides in. |
| <a name="output_vpc_id"></a> [vpc\_id](#output\_vpc\_id) | ID of the VPC |
<!-- END_AUTOMATED_TF_DOCS_BLOCK -->
