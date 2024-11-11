resource "linode_lke_cluster" "this" {
    label       = var.cluster_name
    k8s_version = var.cluster_version
    region      = var.linode_region
    tags        = var.tags

    pool {
        type  = var.node_type
        count = var.node_count
    }
}