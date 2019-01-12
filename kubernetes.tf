module "etcd" {
  source   = "modules/etcd"
  host_ip  = "${var.ips["dovpn"]}"
  data_dir = "/mnt/xwing/etcd"

  bootkube_asset_dir = "/etc/kube-assets"

  providers = {
    docker = "docker.sydney"
  }

  depends_on = "${module.bootkube-start.image}"
}

module "kubelet-master" {
  source     = "modules/kubelet"
  depends_on = "${module.bootkube-start.image}"

  providers = {
    docker = "docker.sydney"
  }
}

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
  depends_on = "${module.bootkube-render.image}"
  source     = "modules/bootkube"
  mode       = "start"
  host_ip    = "${var.ips["dovpn"]}"
  k8s_host   = "k8s.${var.root-domain}"

  providers = {
    docker = "docker.sydney"
  }
}
