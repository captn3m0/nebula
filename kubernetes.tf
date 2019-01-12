module "etcd" {
  source   = "modules/etcd"
  host_ip  = "${var.ips["dovpn"]}"
  data_dir = "/mnt/xwing/etcd"

  providers = {
    docker = "docker.sydney"
  }
}
