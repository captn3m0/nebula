variable "host_ip" {
  description = "Host IP Address to bind etcd to"
  type        = "string"
  default     = "0.0.0.0"
}

variable "data_dir" {
  description = "Directory on host to mount to /etcd-data"
  type        = "string"
}

variable "bootkube_asset_dir" {
  description = "bootkube render is run against this directory"
  type        = "string"
  default     = "/etc/kube-assets"
}

variable "node_name" {
  description = "name of the etcd node"
  default     = "master"
}

variable "depends_on" {
  default = []

  type = "list"
}
