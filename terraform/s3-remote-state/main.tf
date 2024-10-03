locals {
  tags = {
    "project" = "tf-infra"
    "owner"   = "KubeCounty"
  }
}

module "name" {
  source = "../aws/modules/s3"
  name   = "tfstate"
  tags   = local.tags
}
