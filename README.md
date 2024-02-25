## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 4.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.67.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_alb"></a> [alb](#module\_alb) | terraform-aws-modules/alb/aws | n/a |
| <a name="module_alb_sg"></a> [alb\_sg](#module\_alb\_sg) | terraform-aws-modules/security-group/aws | n/a |
| <a name="module_asg"></a> [asg](#module\_asg) | terraform-aws-modules/autoscaling/aws | n/a |
| <a name="module_db"></a> [db](#module\_db) | terraform-aws-modules/rds/aws | 5.6.0 |
| <a name="module_ec2_sg"></a> [ec2\_sg](#module\_ec2\_sg) | terraform-aws-modules/security-group/aws | n/a |
| <a name="module_janvi_pri_record"></a> [janvi\_pri\_record](#module\_janvi\_pri\_record) | terraform-aws-modules/route53/aws//modules/records | n/a |
| <a name="module_janvi_pub_record"></a> [janvi\_pub\_record](#module\_janvi\_pub\_record) | terraform-aws-modules/route53/aws//modules/records | n/a |
| <a name="module_rds_sg"></a> [rds\_sg](#module\_rds\_sg) | terraform-aws-modules/security-group/aws | n/a |
| <a name="module_vpc"></a> [vpc](#module\_vpc) | terraform-aws-modules/vpc/aws | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_key_pair.ec2Key](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/key_pair) | resource |
| [aws_route53_zone_association.rds-vpc-association](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_zone_association) | resource |
| [aws_acm_certificate.issued](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/acm_certificate) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_Owner"></a> [Owner](#input\_Owner) | n/a | `string` | `"janvi.thakkar@intuitive.cloud"` | no |
| <a name="input_ami_id"></a> [ami\_id](#input\_ami\_id) | EC2 AMI ID | `string` | `"ami-006dcf34c09e50022"` | no |
| <a name="input_app_pri_subnets"></a> [app\_pri\_subnets](#input\_app\_pri\_subnets) | Private Subnets for App Tier | `list` | <pre>[<br>  "192.168.67.0/24",<br>  "192.168.68.0/24",<br>  "192.168.69.0/24"<br>]</pre> | no |
| <a name="input_availability_zone"></a> [availability\_zone](#input\_availability\_zone) | Availability Zones | `list(string)` | <pre>[<br>  "us-east-1a",<br>  "us-east-1b",<br>  "us-east-1c"<br>]</pre> | no |
| <a name="input_db_allocated_storage"></a> [db\_allocated\_storage](#input\_db\_allocated\_storage) | Allocated Storage | `number` | `10` | no |
| <a name="input_db_engine"></a> [db\_engine](#input\_db\_engine) | Database Engine | `string` | `"mysql"` | no |
| <a name="input_db_identifier"></a> [db\_identifier](#input\_db\_identifier) | Database Identifier | `string` | `"rds-db"` | no |
| <a name="input_db_instance_class"></a> [db\_instance\_class](#input\_db\_instance\_class) | Database Instance Class | `string` | `"db.t2.micro"` | no |
| <a name="input_db_max_allocated_storage"></a> [db\_max\_allocated\_storage](#input\_db\_max\_allocated\_storage) | Maximum Allocated Storage | `number` | `10` | no |
| <a name="input_db_module_version"></a> [db\_module\_version](#input\_db\_module\_version) | RDS DB Module Version | `string` | `"5.6.0"` | no |
| <a name="input_db_name"></a> [db\_name](#input\_db\_name) | Database Name | `string` | `"janvithakkartrial"` | no |
| <a name="input_db_pri_subnets"></a> [db\_pri\_subnets](#input\_db\_pri\_subnets) | Public Subnets for DB Tier | `list` | <pre>[<br>  "192.168.70.0/24",<br>  "192.168.71.0/24",<br>  "192.168.72.0/24"<br>]</pre> | no |
| <a name="input_domain"></a> [domain](#input\_domain) | Domain Prefix | `string` | `"dns-poc-onprem.tk"` | no |
| <a name="input_ec2_desire"></a> [ec2\_desire](#input\_ec2\_desire) | Desire Numbers for EC2 Instances | `number` | `2` | no |
| <a name="input_ec2_max"></a> [ec2\_max](#input\_ec2\_max) | Max Numbers for EC2 Instances | `number` | `2` | no |
| <a name="input_ec2_min"></a> [ec2\_min](#input\_ec2\_min) | Min Numbers for EC2 Instances | `number` | `1` | no |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | EC2 Instance Type | `string` | `"t2.micro"` | no |
| <a name="input_lab_tag"></a> [lab\_tag](#input\_lab\_tag) | n/a | `string` | `"three-tier-architecture"` | no |
| <a name="input_password"></a> [password](#input\_password) | Password for RDS | `string` | `"janvithakkar"` | no |
| <a name="input_practice_tag"></a> [practice\_tag](#input\_practice\_tag) | Tags | `string` | `"janvi-practice-labs"` | no |
| <a name="input_pri_zone_id"></a> [pri\_zone\_id](#input\_pri\_zone\_id) | Private Zone ID | `string` | `"Z09600291FQN85FFRHCOB"` | no |  
| <a name="input_pub_zone_id"></a> [pub\_zone\_id](#input\_pub\_zone\_id) | Public Zone ID | `string` | `"Z09694789KLKEHOHJN0T"` | no |    
| <a name="input_rds_fqdn"></a> [rds\_fqdn](#input\_rds\_fqdn) | RDS FQDN | `string` | `"janvithakkar-rds.dns-poc-onprem.tk"` | no |       
| <a name="input_ssl_policy"></a> [ssl\_policy](#input\_ssl\_policy) | SSL Policy | `string` | `"ELBSecurityPolicy-2016-08"` | no |        
| <a name="input_storage_type"></a> [storage\_type](#input\_storage\_type) | Storage Type | `string` | `"gp2"` | no |
| <a name="input_username"></a> [username](#input\_username) | RDS DB Username | `string` | `"username"` | no |
| <a name="input_vpc_cidr"></a> [vpc\_cidr](#input\_vpc\_cidr) | Cidr for VPC | `string` | `"192.168.64.0/20"` | no |
| <a name="input_web_pub_subnets"></a> [web\_pub\_subnets](#input\_web\_pub\_subnets) | Public Subnets for Web Tier | `list` | <pre>[<br>  "192.168.64.0/24",<br>  "192.168.65.0/24",<br>  "192.168.66.0/24"<br>]</pre> | no |

## Outputs

No outputs.
