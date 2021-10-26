provider "aws" {
    region = "ap-northeast-1"
}
module "aws_ssm_parameter_store" {
    source = "./modules/ssm"
    store_name = "step-functions-sample"
}
