#Cidr for VPC
variable "vpc_cidr" {
  type    = string
  default = "192.168.64.0/20"
}

#Availability Zones
variable "availability_zone" {
  type    = list(string)
  default = ["us-east-1a", "us-east-1b", "us-east-1c"]
}

#Public Subnets for Web Tier
variable "web_pub_subnets" {
  default = ["192.168.64.0/24", "192.168.65.0/24", "192.168.66.0/24"]
}

#Private Subnets for App Tier
variable "app_pri_subnets" {
  default = ["192.168.67.0/24", "192.168.68.0/24", "192.168.69.0/24"]
}

#Public Subnets for DB Tier
variable "db_pri_subnets" {
  default = ["192.168.70.0/24", "192.168.71.0/24", "192.168.72.0/24"]
}

#Tags
variable "practice_tag" {
  type    = string
  default = "janvi-practice-labs"
}

variable "lab_tag" {
  type    = string
  default = "three-tier-architecture"
}

variable "Owner" {
  type    = string
  default = "janvi.thakkar@intuitive.cloud"
}

#EC2 Instance Type
variable "instance_type" {
  type    = string
  default = "t2.micro"
}

#EC2 AMI ID
variable "ami_id" {
  type    = string
  default = "ami-006dcf34c09e50022"
}

#Password for RDS
variable "password" {
  type    = string
  default = "password" #YOUR_DB_PASSWORD
}

#Domain Prefix
variable "domain" {
  type    = string
  default = "dns-poc-onprem.tk"
}

#SSL Policy
variable "ssl_policy" {
  type    = string
  default = "ELBSecurityPolicy-2016-08"
}

#Public Zone ID
variable "pub_zone_id" {
  type    = string
  default = "ZXXXXXXXXXXXXXXXXXXXXX" #This is the dummy one
}

#Private Zone ID
variable "pri_zone_id" {
  type    = string
  default = "ZXXXXXXXXXXXXXXXXXXXXX"  #This is the dummy one
}

#RDS FQDN
variable "rds_fqdn" {
  type    = string
  default = "janvithakkar-rds.dns-poc-onprem.tk"
}

#Max Numbers for EC2 Instances
variable "ec2_max" {
  type    = number
  default = 2
}

#Min Numbers for EC2 Instances
variable "ec2_min" {
  type    = number
  default = 1
}

#Desire Numbers for EC2 Instances
variable "ec2_desire" {
  type    = number
  default = 2
}

#Storage Type
variable "storage_type" {
  type    = string
  default = "gp2"
}

#Database Name
variable "db_name" {
  type    = string
  default = "janvithakkartrial"
}

#Database Identifier
variable "db_identifier" {
  type    = string
  default = "rds-db"
}

#Database Engine
variable "db_engine" {
  type    = string
  default = "mysql"
}

#Database Instance Class
variable "db_instance_class" {
  type    = string
  default = "db.t2.micro"
}

#RDS DB Module Version
variable "db_module_version" {
  type    = string
  default = "5.6.0"
}

#Allocated Storage
variable "db_allocated_storage" {
  type    = number
  default = 10
}

#Maximum Allocated Storage
variable "db_max_allocated_storage" {
  type    = number
  default = 10
}

#RDS DB Username
variable "username" {
  type    = string
  default = "username" #YOUR_DB_USERNAME
}
