module "k8s" {
  source        = "modules/k8s"
  cluster_name  = "k8s.${var.root-domain}"
  etcd_domain   = "etcd.${var.root-domain}"
  etcd_data_dir = "/mnt/disk/etcd"
  asset_dir     = "${path.root}/k8s2"
  host_ip       = "${var.ips["dovpn"]}"

  providers = {
    docker = "docker.sydney"
  }
}
