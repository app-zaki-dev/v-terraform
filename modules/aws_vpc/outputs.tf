# 出力ファイル
output "region" {
  value = var.region
}

output "project_name" {
  value = var.project_name
}

output "vpc_id" {
  value = aws_vpc.zaki_vpc.id
}

output "public_subnet_az1_id" {
  value = aws_subnet.public_subnet_az1.id
}

output "public_subnet_az2_id" {
  value = aws_subnet.public_subnet_az2.id
}

output "private_subnet_app_az1_id" {
  value = aws_subnet.private_app_subnet_az1.id
}

output "public_subnet_app_az2_id" {
  value = aws_subnet.private_app_subnet_az2.id
}

output "private_subnet_data_az1_id" {
  value = aws_subnet.private_data_subnet_az1.id
}

output "public_subnet_data_az2_id" {
  value = aws_subnet.private_data_subnet_az2.id
}

output "igw" {
  value = aws_internet_gateway.zaki_igw
}
