AWS lb target group Terraform module
=====================================

[![Opstree Solutions][opstree_avatar]][opstree_homepage]

[Opstree Solutions][opstree_homepage] 

  [opstree_homepage]: https://opstree.github.io/
  [opstree_avatar]: https://img.cloudposse.com/150x150/https://github.com/opstree.png

Terraform module which creates lb target group on AWS.

These types of resources are supported:

* [lb_target_group](https://www.terraform.io/docs/providers/aws/r/lb_target_group.html)

Terraform versions
------------------

Terraform 0.12.

Usage
------

```hcl
provider "aws" {
  region = "ap-south-1"
}

module "lb_target_group" {
  source                            = "../alb_target_group"
  applicaton_name                   = "Nginx"
  applicaton_port                   = 80
  tg_target_type                    = "instance"
  tg_protocol                       = "HTTP"
  vpc_id                            = "vpc-09876xyz"
  applicaton_health_check_target    = "/login"
  instance_id                       = "i-092e93733xyz"
}

```

```
output "lb_target_group_arn" {
  description = "instance ip"
  value       = module.lb_target_group.target_group_arn
}
```
Tags
----
* Tags are assigned to resources with name variable as prefix.
* Additial tags can be assigned by tags variables as defined above.

Inputs
------
| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| applicaton_name | Define the name of the application | `string` | `"false"` | yes |
| applicaton_port | Define the application port  | `string` | `"false"` | yes |
| tg_target_type | You can define the type of target group | `string` | `"instance"` | no |
| tg_protocol | Define target group protocol | `string` | `"HTTP"` | no |
| vpc_id | Define vpc id  | `string` | `"false"` | yes |
| applicaton_health_check_target |define application heath check target | `string` | `"false"` | yes |
| instance_id |define Instance ID | `sting` | `"false"` | yes |


Output
------
| Name | Description |
|------|-------------|
| lb_target_group_arn | The ARN of the target group |

## Related Projects

Check out these related projects.

- [security_group](https://github.com/OT-CLOUD-KIT/terraform-aws-network-skeleton) - Terraform module for creating dynamic Security 
- [ec2_instance](https://github.com/OT-CLOUD-KIT/terraform-aws-ec2-instance) -
Terraform mudule for creating ec2 instance
- [route53_record_mapping](https://github.com/OT-CLOUD-KIT/terraform-aws-route53-record-mapping) -
Terraform module for route53 dns mapping mapping 
- [aws_vpc](https://github.com/OT-CLOUD-KIT/terraform-aws-vpc) -
Terraform module for creating vpc
- [eks](https://github.com/OT-CLOUD-KIT/terraform-aws-eks) -
Terraform module for creating eks cluster


### Contributors

[![Devesh Sharma][devesh_avataar]][devesh_homepage]<br/>[Devesh Sharma][devesh_homepage] 

  [devesh_homepage]: https://github.com/deveshs23
  [devesh_avataar]: https://img.cloudposse.com/150x150/https://github.com/deveshs23.png
