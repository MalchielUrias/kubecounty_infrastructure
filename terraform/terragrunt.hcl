generate "provider" {
  path = "provider.tf"
  if_exists = "overwrite"
  contents = <<EOF
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }

    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.33.0"
    }

    helm = {
      source  = "hashicorp/helm"
      version = "2.16.1"
    }

    linode = {
      source  = "linode/linode"
    }
  }
}

provider "aws" {
  region  = "eu-west-1"
}

provider "linode" {
  token = var.token
}

provider "kubernetes" {
  config_path = "~/.kube/k3sconfig"
}

provider "helm" {
  kubernetes {
    config_path = "~/.kube/k3sconfig"
  }
}

EOF
}

remote_state {
  backend = "s3"
  generate = {
    path      = "remote-state.tf"
    if_exists = "overwrite"
  }
  config = {
    bucket = "kubecounty-tfstate"

    key = "${path_relative_to_include()}/terraform.tfstate"
    region         = "eu-west-1"
    encrypt        = false
  }
}

terraform {
  extra_arguments "common_vars" {
    commands = ["plan"]

    arguments = [
        "-out", "./.plans/out.tfplan"
    ]
  }

  before_hook "mkdir_before_hook" {
      commands     = ["plan"]
      execute      = ["mkdir", "-p", "./.plans"]
      run_on_error = false
  }

  before_hook "before_hook" {
    commands     = ["apply", "plan"]
    execute      = ["echo", "Running Terraform Config"]
  }

  after_hook "after_hook" {
    commands     = ["apply", "plan"]
    execute      = ["echo", "Finished running Terraform Config"]
    run_on_error = true
  }
}
