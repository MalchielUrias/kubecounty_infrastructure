# Generated by Terragrunt. Sig: nIlQXj57tbuaRZEa
terraform {
  backend "s3" {
    bucket  = "kubecounty-tfstate"
    encrypt = false
    key     = "platform/terraform.tfstate"
    # profile = "KubeCounty"
    region = "eu-west-1"
  }
}
