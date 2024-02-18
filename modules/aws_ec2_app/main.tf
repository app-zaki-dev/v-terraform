resource "aws_instance" "app-ec2" {
  // 作成するインスタンスの数
  count                       = var.instance_cnt
  ami                         = var.amiId
  instance_type               = var.instance_type
  key_name                    = var.key_name
  vpc_security_group_ids      = ["${var.alb_security_group_id}"]
  subnet_id                   = var.public_subnet_az1
  associate_public_ip_address = "true"

  tags = {
    Name = "${var.env}-app-instance"
  }
}
