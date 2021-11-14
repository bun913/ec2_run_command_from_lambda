resource "aws_route" "public" {
  destination_cidr_block = var.destination_cidr_block
  route_table_id = var.route_table_id
  gateway_id = var.gateway_id
}

// associate-with-subnet
resource "aws_route_table_association" "ig_public" {
  subnet_id = var.subnet_id
  route_table_id = var.route_table_id
}

