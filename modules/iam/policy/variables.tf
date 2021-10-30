variable "policy_name" {
  type = string
}

variable "description" {
  type = string
  default = ""
}
variable "sid" {
  type = string
}
variable "actions" {
  type = list
}

variable "resources" {
  type = list
}
variable "tags" {
  type = map
  default = {}
}
