#RDS DB Module
module "db" {
  source     = "terraform-aws-modules/rds/aws"
  version    = "5.6.0"
  identifier = var.db_identifier
  engine                = var.db_engine
  instance_class        = var.db_instance_class
  allocated_storage     = var.db_allocated_storage
  max_allocated_storage = var.db_max_allocated_storage

  create_random_password              = false
  db_name                             = var.db_name
  username                            = var.username
  password                            = var.password
  port                                = 3306
  iam_database_authentication_enabled = true
  availability_zone                   = var.availability_zone[0]
  create_db_option_group              = false
  create_db_parameter_group           = false
  create_db_subnet_group              = true

  storage_type           = var.storage_type
  storage_encrypted      = false
  publicly_accessible    = false
  vpc_security_group_ids = [module.rds_sg.security_group_id]

  tags = {
    Owner = var.Owner
    Lab   = var.lab_tag
    Name  = "${var.practice_tag}-db"
  } 

  subnet_ids          = module.vpc.database_subnets
  skip_final_snapshot = true
}
