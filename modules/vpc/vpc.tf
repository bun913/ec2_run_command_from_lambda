resource "aws_vpc" "main" {
  cidr_block = var.cidr_block
  tags = var.tags
}

resource "aws_subnet" "main" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.subnet_cidr
  tags = var.tags
}
