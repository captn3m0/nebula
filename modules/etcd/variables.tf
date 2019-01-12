variable "host_ip" {
  description = "Host IP Address to bind etcd to"
  type        = "string"
  default     = "0.0.0.0"
}

variable "data_dir" {
  description = "Directory on host to mount to /etcd-data"
  type        = "string"
}

variable "node_name" {
  description = "name of the etcd node"
  default     = "master"
}
