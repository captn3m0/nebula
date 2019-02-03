variable "version" {
  description = "kubelet version"
  default     = "1.13.2"
}

variable "node_label" {
  description = "kubelet version"
  default     = "node-role.kubernetes.io/master"
}

variable "node_taints" {
  description = "node taints"
  default     = "node-role.kubernetes.io/master=:NoSchedule"
}

variable "depends_on" {
  default = []

  type = "list"
}

variable "asset_dir_volume_name" {
  default = "k8s-assets"
}

variable "host_ip" {}

variable "dns_ip" {
  default = "10.25.0.10"
}

variable "k8s_host" {
  description = "kubenetes hostname"
}

variable "assets" {
  type = "map"
}
