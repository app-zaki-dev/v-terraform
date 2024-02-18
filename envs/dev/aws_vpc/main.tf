provider "aws" {
  region  = var.region
  profile = var.aws_profile
}

# tfvarsファイルはs3管理
terraform {
  backend "s3" {
  }
}

# vpc
module "zaki_vpc" {
  source                       = "../../../modules/aws_vpc"
  region                       = var.region
  project_name                 = var.project_name
  vpc_cidr                     = var.vpc_cidr
  public_subnet_az1_cidr       = var.public_subnet_az1_cidr
  public_subnet_az2_cidr       = var.public_subnet_az2_cidr
  private_subnet_app_az1_cidr  = var.private_subnet_app_az1_cidr
  private_subnet_app_az2_cidr  = var.private_subnet_app_az2_cidr
  private_subnet_data_az1_cidr = var.private_subnet_data_az1_cidr
  private_subnet_data_az2_cidr = var.private_subnet_data_az2_cidr
}

# セキュリティグループ
module "security_group" {
  source         = "../../../modules/aws_security_group"
  sg-name        = var.sg-name
  sg-description = var.sg-description
  vpc_id         = module.zaki_vpc.vpc_id
}

# EC2
module "app-ec2" {
  source                = "../../../modules/aws_ec2_app"
  env                   = var.env
  instance_cnt          = var.instance_cnt
  amiId                 = var.amiId
  key_name              = var.key_name
  instance_type         = var.instance_type
  alb_security_group_id = module.security_group.alb_security_group_id
  public_subnet_az1     = module.zaki_vpc.public_subnet_az1_id
}
