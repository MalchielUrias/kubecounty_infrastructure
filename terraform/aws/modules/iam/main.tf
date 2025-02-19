resource "aws_iam_role" "this" {
  name               = var.iam_role_name
  assume_role_policy = var.assume_role_policy
}

resource "aws_iam_policy" "this" {
  name        = var.policy_name
  description = var.policy_description
  policy      = var.policy
}

resource "aws_iam_role_policy_attachment" "attach-deploy" {
  role       = aws_iam_role.this
  policy_arn = aws_iam_policy.this.arn
}
