#Public DNS Record for ALB
module "janvi_pub_record" {
  source  = "terraform-aws-modules/route53/aws//modules/records"
  zone_id = var.pub_zone_id
  records = [
    {
      name    = "janvithakkar"
      type    = "CNAME"
      records = [module.alb.lb_dns_name]
      ttl     = 5
    }
  ]
}

#Private DNS Record for RDS
module "janvi_pri_record" {
  source  = "terraform-aws-modules/route53/aws//modules/records"
  zone_id = var.pri_zone_id
  records = [
    {
      name    = "janvithakkar-rds"
      type    = "CNAME"
      records = [module.db.db_instance_address]
      ttl     = 5
    }
  ]
}

#RDS VPC Association
resource "aws_route53_zone_association" "rds-vpc-association" {
  zone_id = var.pri_zone_id
  vpc_id  = module.vpc.vpc_id
}
