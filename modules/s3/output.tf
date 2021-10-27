# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket
output "id" {
  value = aws_s3_bucket.bucket.id
}
