// create S3 bucket
module "aws_s3_bucket" {
  source      = "./modules/s3"
  bucket_name = local.secrets.s3.name
  tags        = local.secrets.s3.tags
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

