variable "version" {
  description = "kubelet version"
  default     = "1.13.2"
}

variable "node_label" {
  description = "kubelet version"
  default     = "node.kubernetes.io/master"
}

variable "depends_on" {
  default = []

  type = "list"
}

variable "asset_dir_volume_name" {
  default = "k8s-assets"
}
