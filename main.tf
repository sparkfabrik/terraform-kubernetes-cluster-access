locals {
  developer_is_enabled                                    = length(var.developer_groups) > 0
  admin_is_enabled                                        = length(var.admin_groups) > 0
  enable_nodes_info_and_metrics_for_developers_is_enabled = local.developer_is_enabled && var.enable_nodes_info_and_metrics_for_developers
  enable_nodes_info_and_metrics_for_admins_is_enabled     = local.admin_is_enabled && var.enable_nodes_info_and_metrics_for_admins
}

# ClusterRole for fetch information about nodes
resource "kubernetes_cluster_role_v1" "nodes_info" {
  count = local.enable_nodes_info_and_metrics_for_developers_is_enabled || local.enable_nodes_info_and_metrics_for_admins_is_enabled ? 1 : 0

  metadata {
    name   = "${var.rbac_name_prefix}:nodes-info"
    labels = var.k8s_labels
  }

  rule {
    api_groups = [""]
    resources  = ["nodes"]
    verbs      = ["get", "list"]
  }

  rule {
    api_groups = ["metrics.k8s.io"]
    resources  = ["nodes"]
    verbs      = ["list"]
  }
}

###################
# DEVELOPER LEVEL #
###################

# ClusterRole for namespace scoped resources
resource "kubernetes_cluster_role_v1" "developer" {
  count = local.developer_is_enabled ? 1 : 0

  metadata {
    name   = "${var.rbac_name_prefix}:developer"
    labels = var.k8s_labels
  }

  rule {
    api_groups = ["", "apps", "batch", "extensions"]
    resources = [
      "configmaps",
      "cronjobs",
      "deployments",
      "events",
      "ingresses",
      "ingresses/status",
      "pods",
      "pods/log",
      "pods/portforward",
      "replicasets",
      "secrets",
      "services",
    ]
    verbs = ["get", "list", "watch"]
  }

  rule {
    api_groups = [""]
    resources  = ["pods/exec", "pods/portforward"]
    verbs      = ["create"]
  }

  rule {
    api_groups = ["metrics.k8s.io"]
    resources  = ["pods"]
    verbs      = ["list"]
  }
}

# RoleBinding for namespace scoped resources
resource "kubernetes_role_binding_v1" "developer" {
  for_each = local.developer_is_enabled ? toset(var.namespaces) : []

  metadata {
    name      = "${var.rbac_name_prefix}:developer"
    namespace = each.value
    labels    = var.k8s_labels
  }

  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = kubernetes_cluster_role_v1.developer[0].metadata[0].name
  }

  dynamic "subject" {
    for_each = var.developer_groups
    content {
      api_group = "rbac.authorization.k8s.io"
      kind      = "Group"
      name      = subject.value
    }
  }
}

# ClusterRoleBinding for cluster scoped resources
resource "kubernetes_cluster_role_binding_v1" "nodes_info_for_developers" {
  count = local.enable_nodes_info_and_metrics_for_developers_is_enabled ? 1 : 0

  metadata {
    name   = "${var.rbac_name_prefix}:nodes-info-for-developers"
    labels = var.k8s_labels
  }

  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = kubernetes_cluster_role_v1.nodes_info[0].metadata[0].name
  }

  dynamic "subject" {
    for_each = var.developer_groups
    content {
      api_group = "rbac.authorization.k8s.io"
      kind      = "Group"
      name      = subject.value
    }
  }
}

###############
# ADMIN LEVEL #
###############

# ClusterRole for namespace scoped resources
resource "kubernetes_cluster_role_v1" "admin" {
  count = local.admin_is_enabled ? 1 : 0

  metadata {
    name   = "${var.rbac_name_prefix}:admin"
    labels = var.k8s_labels
  }

  rule {
    api_groups = ["", "apps", "autoscaling", "batch", "extensions"]
    resources  = ["*"]
    verbs      = ["*"]
  }

  rule {
    api_groups = ["metrics.k8s.io"]
    resources  = ["pods"]
    verbs      = ["list"]
  }
}

# RoleBinding for namespace scoped resources
resource "kubernetes_role_binding_v1" "admin" {
  for_each = local.admin_is_enabled ? toset(var.namespaces) : []

  metadata {
    name      = "${var.rbac_name_prefix}:admin"
    namespace = each.value
    labels    = var.k8s_labels
  }

  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = kubernetes_cluster_role_v1.admin[0].metadata[0].name
  }

  dynamic "subject" {
    for_each = var.admin_groups
    content {
      api_group = "rbac.authorization.k8s.io"
      kind      = "Group"
      name      = subject.value
    }
  }
}

# ClusterRoleBinding for cluster scoped resources
resource "kubernetes_cluster_role_binding_v1" "nodes_info_for_admins" {
  count = local.enable_nodes_info_and_metrics_for_admins_is_enabled ? 1 : 0

  metadata {
    name   = "${var.rbac_name_prefix}:nodes-info-for-admins"
    labels = var.k8s_labels
  }

  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = kubernetes_cluster_role_v1.nodes_info[0].metadata[0].name
  }

  dynamic "subject" {
    for_each = var.admin_groups
    content {
      api_group = "rbac.authorization.k8s.io"
      kind      = "Group"
      name      = subject.value
    }
  }
}
