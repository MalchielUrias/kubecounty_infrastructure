data "aws_iam_policy_document" "oidc" {
  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]

    principals {
      type        = "Federated"
      identifiers = [aws_iam_openid_connect_provider.this.arn]
    }

    condition {
      test     = "StringEquals"
      values   = ["sts.amazonaws.com"]
      variable = "token.actions.githubusercontent.com:aud"
    }

    condition {
      test     = "StringLike"
      values   = ["repo:MalchielUrias/*"]
      variable = "token.actions.githubusercontent.com:sub"
    }
  }
}

data "aws_iam_policy_document" "ec2" {
  statement {
    effect = "Allow"
    actions = [
      "ec2:*",
    ]
    resources = [module.master_node.arn]
  }
}

module "github_iam" {
  source             = "../../aws/modules/iam"
  iam_role_name      = var.iam_name
  assume_role_policy = data.aws_iam_policy_document.oidc
  policy             = data.aws_iam_policy_document.ec2
  policy_name        = "github_oidc"
  policy_description = "policy for giving github actions access to aws through oidc"
}
