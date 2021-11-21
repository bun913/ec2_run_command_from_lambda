variable "project_name" {
  type = string
}
variable "vpc_id" {
  type = string
}

variable "tags" {
  type    = map(any)
  default = {}
}

variable "my_ip" {
  type = string
}

