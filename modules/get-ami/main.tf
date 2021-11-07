data "aws_ami" "search" {
  most_recent = var.most_recent
  filter {
    name   = "name"
    values = var.name_filter
  }
  owners = var.owners
}

