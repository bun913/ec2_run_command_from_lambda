module "aws_ssm_params" {
  source     = "../ssm"
  store_name = "step-functions-sample"
}

locals {
  secrets = module.aws_ssm_params.params
}

// create iam_policy
module "ec2_policy" {
  source         = "./policy"
  sid            = "1"
  s3_policy_name = "${var.project_name}_s3_read_policy"
  actions = [
    "s3:List*",
    "s3:Get*",
  ]
  resources = [
    "${var.s3_arn}",
    "${var.s3_arn}/*"
  ]
  ssm_policy_name  = "${var.project_name}_ssm_policy"
  policy_file_path = "./files/ssm_policy.json"
}

// create-role
module "ec2_iam_role" {
  source                = "./role"
  role_name             = "${var.project_name}_ec2"
  actions               = ["sts:AssumeRole"]
  principal_type        = "Service"
  principal_identifiers = ["ec2.amazonaws.com"]
}

// attach-role
module "attach_s3_role" {
  source     = "./attach"
  role_name  = module.ec2_iam_role.iam_role.name
  policy_arn = module.ec2_policy.s3_policy.arn
}

module "attach_ssm_role" {
  source     = "./attach"
  role_name  = module.ec2_iam_role.iam_role.name
  policy_arn = module.ec2_policy.ssm_policy.arn
}
# Instance Profile
resource "aws_iam_instance_profile" "profile" {
  name = module.ec2_iam_role.iam_role.name
  role = module.ec2_iam_role.iam_role.name
}

