module "iam_role" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-role"
  version = "5.39.0"

  name                = var.iam_role_name
  assume_role_policy  = var.assume_role_policy
}

module "iam_policy" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-policy"
  version = "5.39.0"

  name        = var.policy_name
  description = var.policy_description
  policy      = var.policy
}
