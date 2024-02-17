# VPCの作成
resource "aws_vpc" "zaki_vpc" {
  cidr_block           = var.vpc_cidr
  instance_tenancy     = "default"
  enable_dns_hostnames = true

  tags = {
    Name = "${var.project_name}-vpc"
  }
}

# IGWの作成
resource "aws_internet_gateway" "zaki_igw" {
  vpc_id = aws_vpc.zaki_vpc.id

  tags = {
    Name = "${var.project_name}-igw"
  }
}

# データソースを使用して全てのアベイラビリティゾーンを取得 0がa, 1がc
data "aws_availability_zones" "zaki_available_zones" {}

# public subnet a
resource "aws_subnet" "public_subnet_az1" {
  vpc_id                  = aws_vpc.zaki_vpc.id
  cidr_block              = var.public_subnet_az1_cidr
  availability_zone       = data.aws_availability_zones.zaki_available_zones.names[0]
  map_public_ip_on_launch = true

  tags = {
    Name = "public subnet az1"
  }
}

# public subnet c
resource "aws_subnet" "public_subnet_az2" {
  vpc_id                  = aws_vpc.zaki_vpc.id
  cidr_block              = var.public_subnet_az2_cidr
  availability_zone       = data.aws_availability_zones.zaki_available_zones.names[1]
  map_public_ip_on_launch = true

  tags = {
    Name = "public subnet az2"
  }
}

# route table add public route
resource "aws_route_table" "zaki_public_route_table" {
  vpc_id = aws_vpc.zaki_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.zaki_igw.id
  }

  tags = {
    Name = "public route table"
  }
}

# az1 public subnet route table
resource "aws_route_table_association" "public_subnet_az1_route_table_association" {
  subnet_id      = aws_subnet.public_subnet_az1.id
  route_table_id = aws_route_table.zaki_public_route_table.id
}

# az2 public subnet route table
resource "aws_route_table_association" "public_subnet_az2_route_table_association" {
  subnet_id      = aws_subnet.public_subnet_az2.id
  route_table_id = aws_route_table.zaki_public_route_table.id
}

# private subnet app a
resource "aws_subnet" "private_app_subnet_az1" {
  vpc_id                  = aws_vpc.zaki_vpc.id
  cidr_block              = var.private_subnet_app_az1_cidr
  availability_zone       = data.aws_availability_zones.zaki_available_zones.names[0]
  map_public_ip_on_launch = false // これでパブリックIPが自動付与されない

  tags = {
    Name = "private subnet app az1"
  }
}

# private subnet app c
resource "aws_subnet" "private_app_subnet_az2" {
  vpc_id                  = aws_vpc.zaki_vpc.id
  cidr_block              = var.private_subnet_app_az2_cidr
  availability_zone       = data.aws_availability_zones.zaki_available_zones.names[1]
  map_public_ip_on_launch = false // これでパブリックIPが自動付与されない

  tags = {
    Name = "private subnet app az2"
  }
}

# private subnet data a
resource "aws_subnet" "private_data_subnet_az1" {
  vpc_id                  = aws_vpc.zaki_vpc.id
  cidr_block              = var.private_subnet_data_az1_cidr
  availability_zone       = data.aws_availability_zones.zaki_available_zones.names[0]
  map_public_ip_on_launch = false // これでパブリックIPが自動付与されない

  tags = {
    Name = "private subnet data az1"
  }
}

# private subnet data c
resource "aws_subnet" "private_data_subnet_az2" {
  vpc_id                  = aws_vpc.zaki_vpc.id
  cidr_block              = var.private_subnet_data_az2_cidr
  availability_zone       = data.aws_availability_zones.zaki_available_zones.names[1]
  map_public_ip_on_launch = false // これでパブリックIPが自動付与されない

  tags = {
    Name = "private subnet data az2"
  }
}
