data "aws_iam_policy_document" "policy_doc" {
  statement {
    sid = var.sid
    actions = var.actions
    resources = var.resources
  }
}

resource "aws_iam_policy" "policy" {
  name        = var.policy_name
  description = var.description
  policy = data.aws_iam_policy_document.policy_doc.json
}
