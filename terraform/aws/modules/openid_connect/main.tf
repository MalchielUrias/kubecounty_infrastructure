resource "aws_iam_openid_connect_provider" "this" {
  url = var.url

  client_id_list = var.client_id_list

  thumbprint_list = ["D89E3BD43D5D909B47A18977AA9D5CE36CEE184C"]
}
