module "linode-cluster" {
  source = "../../linode/modules/kubernetes"
  cluster_name = var.cluster_name
  cluster_version = var.cluster_version
  node_type = var.node_type
  node_count = var.node_count
  linode_region = var.linode_region
  tags = var.tags
}