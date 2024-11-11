output "k8s_dashboard" {
  value = linode_lke_cluster.this.dashboard_url
}

output "kubeconfig" {
  value = linode_lke_cluster.this.kubeconfig
}

output "api_server" {
  value = linode_lke_cluster.this.api_endpoints
}