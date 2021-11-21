# security group
resource "aws_security_group" "ec2" {
  name   = "${var.project_name}-simple-sg"
  vpc_id = var.vpc_id
  tags   = var.tags
}

// sg_inbuound_rule
resource "aws_security_group_rule" "sg_ingress_rule" {
  security_group_id = aws_security_group.ec2.id
  type              = "ingress"
  from_port         = "22"
  to_port           = "22"
  protocol          = "TCP"
  cidr_blocks       = ["${var.my_ip}/32"]
}

// sg_outbound_rule
resource "aws_security_group_rule" "sg_egress_rule" {
  security_group_id = aws_security_group.ec2.id
  type              = "egress"
  to_port           = "443"
  from_port         = "443"
  protocol          = "TCP"
  cidr_blocks       = ["0.0.0.0/0"]
}

