module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "${var.practice_tag}-vpc"
  cidr = var.vpc_cidr

  azs                    = var.availability_zone
  private_subnets        = var.app_pri_subnets
  database_subnets       = var.db_pri_subnets
  public_subnets         = var.web_pub_subnets
  enable_dns_hostnames   = true
  enable_dns_support     = true
  enable_nat_gateway     = true
  single_nat_gateway     = true
  one_nat_gateway_per_az = false
  enable_vpn_gateway     = false

  tags = {
    Owner = var.Owner
    Lab   = var.lab_tag
    Name  = "${var.practice_tag}-vpc"
  }
}

# Security Group for ALB
module "alb_sg" {
  source = "terraform-aws-modules/security-group/aws"
  name   = "${var.practice_tag}-alb-sg"
  vpc_id = module.vpc.vpc_id

  ingress_with_cidr_blocks = [
    {
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = "0.0.0.0/0"
    },
    {
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      cidr_blocks = "0.0.0.0/0"
    }
  ]

  egress_with_cidr_blocks = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = "0.0.0.0/0"
    }
  ]

  tags = {
    Owner = var.Owner
    Lab   = var.lab_tag
    Name  = "${var.practice_tag}-alb-sg"
  }
}

# Security Group for EC2
module "ec2_sg" {
  source = "terraform-aws-modules/security-group/aws"
  name   = "${var.practice_tag}-ec2-sg"
  vpc_id = module.vpc.vpc_id

  computed_ingress_with_source_security_group_id = [
    {
      from_port                = 80
      to_port                  = 80
      protocol                 = "tcp"
      source_security_group_id = module.alb_sg.security_group_id
    }
  ]

  number_of_computed_ingress_with_source_security_group_id = 1
  egress_with_cidr_blocks = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = "0.0.0.0/0"
    }
  ]

  tags = {
    Owner = var.Owner
    Lab   = var.lab_tag
    Name  = "${var.practice_tag}-ec2-sg"
  }
}

# Security Group for RDS
module "rds_sg" {
  source = "terraform-aws-modules/security-group/aws"
  name   = "${var.practice_tag}-rds-sg"
  vpc_id = module.vpc.vpc_id

  computed_ingress_with_source_security_group_id = [
    {
      from_port                = 3306
      to_port                  = 3306
      protocol                 = "tcp"
      source_security_group_id = module.ec2_sg.security_group_id
    }
  ]

  number_of_computed_ingress_with_source_security_group_id = 1
  egress_with_cidr_blocks = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = "0.0.0.0/0"
    }
  ]

  tags = {
    Owner = var.Owner
    Lab   = var.lab_tag
    Name  = "${var.practice_tag}-rds-sg"
  }
}
