# security group
resource "aws_security_group" "ec2" {
  name   = "${var.project_name}-simple-sg"
  vpc_id = var.vpc_id
  tags = var.tags
}
