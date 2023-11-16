# Cluster access

## Roles description

This module creates `ClusterRole` and `RoleBinding` in the specified namespace with two access levels:

1. `developer_groups` is a list of groups that will have access as simple readers to the specified namespaces; they can only get the current deployed resources, read pod logs and exec commands inside the pods.
2. `admin_groups` is a list of groups that will have access as admin to the specified namespace; they can do anything on the current deployed resources

If the `enable_nodes_info_and_metrics_for_developers` and/or `enable_nodes_info_and_metrics_for_admins` are enabled, the `developer_groups` and/or `admin_groups` will have reading access to the `nodes` resources to get information and metrics about them.

<!-- BEGIN_TF_DOCS -->
## Providers

| Name | Version |
|------|---------|
| <a name="provider_kubernetes"></a> [kubernetes](#provider\_kubernetes) | >= 2.23 |

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | >= 2.23 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_admin_groups"></a> [admin\_groups](#input\_admin\_groups) | The list of groups to grant admin access to | `list(string)` | `[]` | no |
| <a name="input_developer_groups"></a> [developer\_groups](#input\_developer\_groups) | The list of groups to grant developer access to | `list(string)` | `[]` | no |
| <a name="input_enable_nodes_info_and_metrics_for_admins"></a> [enable\_nodes\_info\_and\_metrics\_for\_admins](#input\_enable\_nodes\_info\_and\_metrics\_for\_admins) | Whether to enable the nodes informations and metrics for admins groups. This requires to create a ClusterRole and a ClusterRoleBinding | `bool` | `true` | no |
| <a name="input_enable_nodes_info_and_metrics_for_developers"></a> [enable\_nodes\_info\_and\_metrics\_for\_developers](#input\_enable\_nodes\_info\_and\_metrics\_for\_developers) | Whether to enable the nodes informations and metrics for developers groups. This requires to create a ClusterRole and a ClusterRoleBinding | `bool` | `true` | no |
| <a name="input_k8s_labels"></a> [k8s\_labels](#input\_k8s\_labels) | The labels to apply to the Kubernetes resources | `map(string)` | <pre>{<br>  "scope": "cluster-access"<br>}</pre> | no |
| <a name="input_namespaces"></a> [namespaces](#input\_namespaces) | The list of namespaces to grant access to | `list(string)` | n/a | yes |
| <a name="input_rbac_name_prefix"></a> [rbac\_name\_prefix](#input\_rbac\_name\_prefix) | The prefix to use for the RBAC resources | `string` | `"custom:cluster-access"` | no |

## Outputs

No outputs.

## Resources

| Name | Type |
|------|------|
| [kubernetes_cluster_role_binding_v1.nodes_info_for_admins](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/cluster_role_binding_v1) | resource |
| [kubernetes_cluster_role_binding_v1.nodes_info_for_developers](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/cluster_role_binding_v1) | resource |
| [kubernetes_cluster_role_v1.admin](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/cluster_role_v1) | resource |
| [kubernetes_cluster_role_v1.developer](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/cluster_role_v1) | resource |
| [kubernetes_cluster_role_v1.nodes_info](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/cluster_role_v1) | resource |
| [kubernetes_role_binding_v1.admin](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/role_binding_v1) | resource |
| [kubernetes_role_binding_v1.developer](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/role_binding_v1) | resource |

## Modules

No modules.


<!-- END_TF_DOCS -->
