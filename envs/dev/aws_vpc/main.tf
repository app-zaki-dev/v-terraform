provider "aws" {
  region  = var.region
  profile = var.aws_profile
}

# tfvarsファイルはs3管理
terraform {
  backend "s3" {
  }
}

# vpcモジュールを使用
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
