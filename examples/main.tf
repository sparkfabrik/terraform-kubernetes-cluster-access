module "cluster_access" {
  source  = "github.com/sparkfabrik/terraform-kubernetes-cluster-access"
  version = ">= 0.1.0"

  namespaces       = var.namespaces
  developer_groups = var.developer_groups
  admin_groups     = var.admin_groups
}
