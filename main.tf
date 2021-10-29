provider "aws" {
    region = "ap-northeast-1"
}
// Fetch parameter from ssm_parameter_store
module "aws_ssm_params" {
    source = "./modules/ssm"
    store_name = "step-functions-sample"
}

locals {
  secrets = jsondecode(module.aws_ssm_params.params)
}

// create S3 bucket
module "aws_s3_bucket" {
    source = "./modules/s3"
    bucket_name = local.secrets.s3.name
    tags = local.secrets.s3.tags
}

locals {
    policy_map = {
        bucket_arn = module.aws_s3_bucket.arn
    }
}

// create s3_read_iam_policy
module "aws_s3_read_policy" {
  source = "./modules/iam/policy"
  name = "s3-reaad-policy"
  template_file = "./files/s3_read_policy.json"
  var_map = local.policy_map
}
