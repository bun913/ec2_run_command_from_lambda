# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ssm_parameter
data "aws_ssm_parameter" "aws_setting" {
  name = "${var.store_name}"
  with_decryption = true
}
