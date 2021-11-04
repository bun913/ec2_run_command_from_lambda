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

variable "service_name" {
  type = string
}
