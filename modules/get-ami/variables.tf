variable "most_recent" {
  type    = bool
  default = true
}

variable "name_filter" {
  type = list(string)
}

variable "owners" {
  type    = list(any)
  default = ["amazon"]
}

