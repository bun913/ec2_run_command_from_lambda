variable "destination_cidr_block" {
  type    = string
  default = "0.0.0.0/0"
}

variable "route_table_id" {
  type = string
}

variable "gateway_id" {
  type = string
}

variable "subnet_id" {
  type = string
}

