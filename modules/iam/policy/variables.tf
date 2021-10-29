variable "name" {
  type = string
}

variable "description" {
  type = string
  default = ""
}

variable "var_map" {
  type = map
}

variable "template_file" {
  type = string
}
