resource "aws_vpc_endpoint_route_table_association" "vpc_end_route" {
  route_table_id  = var.route_table_id
  vpc_endpoint_id = var.endpoint_id
}

