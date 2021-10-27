provider "aws" {
    region = "ap-northeast-1"
}
module "aws_ssm_params" {
    source = "./modules/ssm"
    store_name = "step-functions-sample"
}

locals {
  secrets = jsondecode(module.aws_ssm_params.params)
}

module "aws_s3_bucket" {
    source = "./modules/s3"
    bucket_name = local.secrets.s3.name
    tags = local.secrets.s3.tags
}
