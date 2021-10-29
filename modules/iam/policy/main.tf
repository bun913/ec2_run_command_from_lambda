resource "aws_iam_policy" "template_file" {
  name = var.name
  description = var.description
  policy = templatefile(
    var.template_file,
    var.var_map
  )
}
