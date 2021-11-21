variable "instance_type" {
  type    = string
  default = "t2.micro"
}

variable "ami_id" {
  type = string
}

variable "tags" {
  type    = map(string)
  default = {}
}

variable "sg_ids" {
  type = list(string)
}

variable "subnet_id" {
  type = string
}

variable "user_data" {
  type    = string
  default = ""
}

variable "key_name" {
  type    = string
  default = ""
}

variable "associate_public_ip_address" {
  type    = bool
  default = false
}

variable "iam_instance_profile" {
  type = string
}

