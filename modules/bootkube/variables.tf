// Based on https://github.com/v1k0d3n/dockerfiles/tree/master/bootkube

variable "asset_dir_volume_name" {
  default = "k8s-assets"
}

variable "k8s_host" {
  description = "kubenetes hostname"
}

variable "host_port" {
  default = "8443"
}

variable "host_ip" {}

variable "pod_cidr" {
  default = "10.25.0.0/16"
}

variable "service_cidr" {
  default = "10.96.0.0/16"
}

variable "mode" {}

variable "version" {
  default = "0.14.0"
}
