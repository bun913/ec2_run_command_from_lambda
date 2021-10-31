provider "aws" {
  region = "ap-northeast-1"
}
// Fetch parameter from ssm_parameter_store
module "aws_ssm_params" {
  source     = "./modules/ssm"
  store_name = "step-functions-sample"
}

locals {
  secrets = jsondecode(module.aws_ssm_params.params)
}

// create S3 bucket
module "aws_s3_bucket" {
  source      = "./modules/s3"
  bucket_name = local.secrets.s3.name
  tags        = local.secrets.s3.tags
}

// create s3_read_iam_policy
module "ec2_iam_policy" {
  source      = "./modules/iam/policy"
  sid         = "1"
  policy_name = "${var.project_name}_s3_read_policy"
  actions = [
    "s3:List*",
    "s3:Get*",
  ]
  resources = [
    "${module.aws_s3_bucket.arn}",
    "${module.aws_s3_bucket.arn}/*"
  ]
}

// create-role
module "ec2_iam_role" {
  source    = "./modules/iam/role"
  role_name = "${var.project_name}_s3_read_role"
  actions   = ["sts:AssumeRole"]
  principal_type = "Service"
  principal_identifiers = ["ec2.amazonaws.com"]
}

// attach-role
module "attach_role" {
  source = "./modules/iam/attach"
  role_name = module.ec2_iam_role.iam_role.name
  policy_arn = module.ec2_iam_policy.policy.arn
}

// create-vpc
module "vpc" {
  source = "./modules/vpc"
  tags = local.secrets.tags
  cidr_block = "10.0.0.0/16"
  subnet_cidr = "10.0.0.0/24"
}
