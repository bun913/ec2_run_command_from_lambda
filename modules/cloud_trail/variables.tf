variable "name" {
  type = string
}

variable "s3_bucket_name" {
  type = string
}

variable "read_write_type" {
  type    = string
  default = "All"
}

variable "include_management_events" {
  type    = bool
  default = true
}

variable "data_resource_values" {
  type = list(string)
}

