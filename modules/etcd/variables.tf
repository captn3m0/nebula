variable "domain" {
  description = "Host name to advertise"
  type        = "string"
}

variable "data_dir" {
  description = "Directory on host to mount to /etcd-data"
  type        = "string"
}

variable "node_name" {
  description = "name of the etcd node"
  default     = "controller"
}

variable "depends_on" {
  default = []

  type = "list"
}

variable "pki" {
  type = "map"
}

variable "version" {
  description = "etcd version"
  default     = "3.3.11"
}

variable "host_bind_ip" {
  description = "IP address to expose the ports on host"
  default     = "0.0.0.0"
}
