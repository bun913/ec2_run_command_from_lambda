variable "cidr_block" {
  type = string
}

variable "subnet_cidr" {
  type = string
}

variable "tags" {
  type    = map(any)
  default = {}
}
