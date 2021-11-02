variable "vpc_id" {
  type = string
}

variable "region" {
  type = string
}

variable "tags" {
  type = map
  default = {}
}
