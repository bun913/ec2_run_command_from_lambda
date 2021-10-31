data "aws_iam_policy_document" "instance-assume-role-policy" {
  statement {
    actions = var.actions
    principals {
      type        = var.principal_type
      identifiers = var.principal_identifiers
    }
  }
}

resource "aws_iam_role" "iam_role" {
  name               = var.role_name
  assume_role_policy = data.aws_iam_policy_document.instance-assume-role-policy.json
}
