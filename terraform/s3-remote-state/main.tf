locals {
  tags = {
    "project" = "tf-infra"
    "owner"   = "KubeCounty"
  }
}

module "tfstate-bucket" {
  source = "../aws/modules/s3"
  name   = var.name
  tags   = local.tags
}
