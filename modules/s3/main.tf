# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket
resource "aws_s3_bucket" "bucket" {
  bucket = "${var.bucket_name}"
  acl    = "private"
  tags = var.tags
}
