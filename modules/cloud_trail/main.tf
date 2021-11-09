resource "aws_cloudtrail" "s3" {
  name           = var.name
  s3_bucket_name = var.s3_bucket_name
  event_selector {
    read_write_type           = var.read_write_type
    include_management_events = var.include_management_events
    data_resource {
      type   = "AWS::S3::Object"
      values = var.data_resource_values
    }
  }
}

