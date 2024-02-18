variable "region" {}
variable "project_name" {}
variable "vpc_cidr" {}
variable "public_subnet_az1_cidr" {}
variable "public_subnet_az2_cidr" {}
variable "private_subnet_app_az1_cidr" {}
variable "private_subnet_app_az2_cidr" {}
variable "private_subnet_data_az1_cidr" {}
variable "private_subnet_data_az2_cidr" {}
variable "aws_profile" {}

# セキュリティグループ
variable "sg-name" {}
variable "sg-description" {}
# EC2
variable "env" {}
variable "instance_cnt" {}
variable "amiId" {}
variable "key_name" {}
variable "instance_type" {}
