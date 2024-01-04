variable "namespaces" {
  type        = list(string)
  description = "The list of namespaces to grant access to"
}

variable "developer_groups" {
  type        = list(string)
  description = "The list of groups to grant developer access to"
  default     = []
}

variable "admin_groups" {
  type        = list(string)
  description = "The list of groups to grant admin access to"
  default     = []
}

variable "k8s_labels" {
  type = map(string)
  default = {
    "scope" = "cluster-access"
  }
  description = "The labels to apply to the Kubernetes resources"
}

variable "rbac_name_prefix" {
  type        = string
  default     = "custom:cluster-access"
  description = "The prefix to use for the RBAC resources"
}

variable "enable_nodes_info_and_metrics_for_developers" {
  type        = bool
  default     = true
  description = "Whether to enable the nodes informations and metrics for developers groups. This requires to create a ClusterRole and a ClusterRoleBinding"
}

variable "enable_nodes_info_and_metrics_for_admins" {
  type        = bool
  default     = true
  description = "Whether to enable the nodes informations and metrics for admins groups. This requires to create a ClusterRole and a ClusterRoleBinding"
}

variable "enable_namespaces_info_for_developers" {
  type        = bool
  default     = false
  description = "Whether to enable the namespaces informations for developers groups. This requires to create a ClusterRole and a ClusterRoleBinding"
}

variable "enable_namespaces_info_for_admins" {
  type        = bool
  default     = false
  description = "Whether to enable the namespaces informations for admins groups. This requires to create a ClusterRole and a ClusterRoleBinding"
}
