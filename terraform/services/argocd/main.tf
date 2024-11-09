resource "random_string" "argocd_password" {
  length           = 16
  special          = true
  min_upper        = 3
  min_lower        = 3
  min_numeric      = 3
  min_special      = 3
  override_special = "!@#%&+/"
}

resource "kubernetes_namespace" "argocd_namespace" {
  metadata {
    name = "argocd"
  }
}

resource "helm_release" "argocd" {
  name             = "argocd"
  chart            = "argo-cd"
  repository       = "https://argoproj.github.io/argo-helm"
  namespace  = "argocd"
  version          = "7.6.11"
  values = [
    templatefile("${path.module}/files/argocd_values.yaml", {
      github_ssh_key = var.github_ssh_key
    })
  ]
}

resource "kubernetes_secret" "github_ssh" {
  metadata {
    name      = "github-ssh"
    namespace = "argocd"
  }

  data = {
    "ssh-private-key" = var.github_ssh_key 
  }
}

