variable "namespaces" {
  type        = list(string)
  description = "The list of namespaces to grant access to"
}

variable "developer_groups" {
  type        = list(string)
  description = "The list of groups to grant developer access to"
}

variable "admin_groups" {
  type        = list(string)
  description = "The list of groups to grant admin access to"
}
