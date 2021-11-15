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
  source                = "./modules/iam/role"
  role_name             = "${var.project_name}_s3_read_role"
  actions               = ["sts:AssumeRole"]
  principal_type        = "Service"
  principal_identifiers = ["ec2.amazonaws.com"]
}

// attach-role
module "attach_role" {
  source     = "./modules/iam/attach"
  role_name  = module.ec2_iam_role.iam_role.name
  policy_arn = module.ec2_iam_policy.policy.arn
}

locals {
  vpc_cidr    = "10.0.0.0/16"
  subnet_cidr = "10.0.0.0/24"
}

// create-vpc
module "vpc" {
  source      = "./modules/vpc"
  tags        = local.secrets.tags
  cidr_block  = local.vpc_cidr
  subnet_cidr = local.subnet_cidr
}

// create-internet-gateway
module "igw" {
  source = "./modules/internet_gateway"
  tags   = local.secrets.tags
  vpc_id = module.vpc.vpc_id
}

// vpc-endpoint for accessing s3
module "vpc_endpoint" {
  source       = "./modules/vpc_endpoint"
  tags         = local.secrets.tags
  vpc_id       = module.vpc.vpc_id
  region       = local.secrets.region
  service_name = "com.amazonaws.ap-northeast-1.s3"
}

// security-group for ec2
module "ec2-sg" {
  source       = "./modules/security_group"
  tags         = local.secrets.tags
  project_name = local.secrets.project
  vpc_id       = module.vpc.vpc_id
}

// get my-ip for sg rule
module "my_ip" {
  source = "./modules/get-my-ip"
}

// sg_inbuound_rule
module "sg_ingress_rule" {
  source      = "./modules/security_group_rule"
  sg_id       = module.ec2-sg.id
  type        = "ingress"
  from_port   = "22"
  to_port     = "22"
  protocol    = "TCP"
  cidr_blocks = ["${module.my_ip.my_ip}/32"]
}

// ec2-ami
module "ami" {
  source      = "./modules/get-ami"
  name_filter = ["amzn2-ami-hvm-2.0.*"]
}

// ec2-instance
module "ec2" {
  source                      = "./modules/ec2"
  ami_id                      = module.ami.ami_id
  instance_type               = "t2.micro"
  subnet_id                   = module.vpc.subnet_id
  sg_ids                      = [module.ec2-sg.id]
  key_name                    = local.secrets.ec2.key_name
  associate_public_ip_address = true
  tags                        = local.secrets.tags
  user_data                   = <<-EOF
  #!/bin/bash
  # Prepare ShellScript
  echo '#/bin/bash' > /tmp/test.sh
  echo 'echo "Do something $(date)"' >> /tmp/test.sh
  chmod 777 /tmp/test.sh
  # SSM Agent
  cd /tmp
  sudo yum install -y https://s3.amazonaws.com/ec2-downloads-windows/SSMAgent/latest/linux_amd64/amazon-ssm-agent.rpm
  sudo systemctl enable amazon-ssm-agent
  sudo systemctl start amazon-ssm-agent
                                EOF
}

// route-table
module "route_table" {
  source = "./modules/route"
  vpc_id = module.vpc.vpc_id
  tags   = local.secrets.tags
}

// vpc-endpoint_route
module "vpc_endpoint_route" {
  source         = "./modules/vpc_endpoint_route"
  endpoint_id    = module.vpc_endpoint.id
  route_table_id = module.route_table.id
}

// internet-gatway-route
module "internet_gw_route" {
  source         = "./modules/internet_gateway_route"
  route_table_id = module.route_table.id
  gateway_id     = module.igw.id
  subnet_id      = module.vpc.subnet_id
}

// cloudtrail for cloudwatch events
// 事前にcloudtrailの証跡保存用のバケットを作成しておく必要がある
module "cloud_trail" {
  source         = "./modules/cloud_trail"
  name           = "ForS3CloudWatchEvents"
  s3_bucket_name = local.secrets.cloud_trail.write_bucket_name
  data_resource_values = [
    "${module.aws_s3_bucket.arn}/"
  ]
}

