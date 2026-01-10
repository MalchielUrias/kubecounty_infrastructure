resource "aws_iam_instance_profile" "test_profile" {
  name = var.instance_profile_name
  role = var.iam_role_name
}