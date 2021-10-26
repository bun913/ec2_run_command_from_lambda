/* # https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy */
/* resource "aws_iam_policy" "file" { */
/*   name   = "file" */
/*   policy = file("./step-function-batch-system-policy.json") */
/* } */

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ssm_parameter
data "aws_ssm_parameter" "aws_setting" {
  name = "${var.store_name}"
  with_decryption = true
}

output "params" {
  value = data.aws_ssm_parameter.aws_setting
}

# https://www.terraform.io/docs/language/functions/templatefile.html
/* resource "aws_iam_policy" "templatefile" { */
/*   name = "templatefile" */
/*   policy = templatefile( */
/*     "./step-function-batch-system-policy.json", */
/*     { */
/*       bucket = local.s3.0.name */
/*     } */
/*   ) */
/* } */

/* data "aws_region" "current" {} */
/* data "aws_caller_identity" "current" {} */
/* resource "aws_dynamodb_table" "book" { */
/*   name     = "Books" */
/*   hash_key = "id" */
/*   attribute { */
/*     name = "id" */
/*     type = "N" */
/*   } */
/*   billing_mode = "PAY_PER_REQUEST" */
/* } */
