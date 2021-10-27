# aws_setting
## https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ssm_parameter
output "params" {
  value = data.aws_ssm_parameter.aws_setting.value
  sensitive = true
}
