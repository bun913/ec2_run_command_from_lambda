// create iam_policy
module "ec2_policy" {
  source         = "./modules/iam/policy"
  sid            = "1"
  s3_policy_name = "${var.project_name}_s3_read_policy"
  actions = [
    "s3:List*",
    "s3:Get*",
  ]
  resources = [
    "${module.aws_s3_bucket.arn}",
    "${module.aws_s3_bucket.arn}/*"
  ]
  ssm_policy_name  = "${var.project_name}_ssm_policy"
  policy_file_path = "./files/ssm_policy.json"
}

// create-role
module "ec2_iam_role" {
  source                = "./modules/iam/role"
  role_name             = "${var.project_name}_ec2"
  actions               = ["sts:AssumeRole"]
  principal_type        = "Service"
  principal_identifiers = ["ec2.amazonaws.com"]
}

// attach-role
module "attach_s3_role" {
  source     = "./modules/iam/attach"
  role_name  = module.ec2_iam_role.iam_role.name
  policy_arn = module.ec2_policy.s3_policy.arn
}

module "attach_ssm_role" {
  source     = "./modules/iam/attach"
  role_name  = module.ec2_iam_role.iam_role.name
  policy_arn = module.ec2_policy.ssm_policy.arn
}

