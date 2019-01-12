module "etcd" {
  source   = "modules/etcd"
  host_ip  = "${var.ips["dovpn"]}"
  data_dir = "/mnt/xwing/etcd"

  providers = {
    docker = "docker.sydney"
  }
}

# module "kubelet" {
#   source = "modules/kubelet"
#   listen_ip =  "${var.ips["dovpn"]}"
# }

module "bootkube-render" {
  source   = "modules/bootkube"
  mode     = "render"
  host_ip  = "${var.ips["dovpn"]}"
  k8s_host = "k8s.${var.root-domain}"

  providers = {
    docker = "docker.sydney"
  }
}

module "bootkube-start" {
  source   = "modules/bootkube"
  mode     = "start"
  host_ip  = "${var.ips["dovpn"]}"
  k8s_host = "k8s.${var.root-domain}"

  providers = {
    docker = "docker.sydney"
  }
}
