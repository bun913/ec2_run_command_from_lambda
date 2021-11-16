data "aws_iam_policy_document" "policy_doc" {
  statement {
    sid       = var.sid
    actions   = var.actions
    resources = var.resources
  }
}

resource "aws_iam_policy" "s3" {
  name        = var.s3_policy_name
  description = var.description
  policy      = data.aws_iam_policy_document.policy_doc.json
}

resource "aws_iam_policy" "ssm" {
  name   = var.ssm_policy_name
  policy = file(var.policy_file_path)
}

