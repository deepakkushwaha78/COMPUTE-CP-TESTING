Route Table Terraform Module
=====================================

[![Opstree Solutions][opstree_avatar]][opstree_homepage]

[Opstree Solutions][opstree_homepage] 

  [opstree_homepage]: https://opstree.github.io/
  [opstree_avatar]: https://img.cloudposse.com/150x150/https://github.com/opstree.png

Terraform module which creates route table on AWS.

Terraform versions
------------------

Terraform 0.12.

Usage
------
```hcl
 source = "./modules/route_table/"  
  vpc_id = var.vpc_id        
  gateway_id = var.igw_id   
  subnet_cidr = var.rtb_cidr 
```

Tags
----
* Tags are assigned to resources with name variable as prefix.
* Additial tags can be assigned by tags variables as defined above.


## Inputs       

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| vpc_id | Id of your vpc | string | null| yes |
| cidr | cidr blocks | string | null | yes |
| gateway_id | Gateway you want to attach ie. "nat gateway" | string | null | yes |
| name | Name of the route table | string | null | yes |     
  

Output
------
| Name | Description |
|------|-------------|
| route_table_id | The ID of the route table |