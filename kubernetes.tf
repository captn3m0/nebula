module "etcd" {
  source       = "modules/etcd"
  data_dir     = "/mnt/disk/etcd"
  host_bind_ip = "10.8.0.1"
  domain       = "etcd.bb8.fun"

  pki = {
    ca_cert     = "${module.bootkube.etcd_ca_cert}"
    server_cert = "${module.bootkube.etcd_server_cert}"
    server_key  = "${module.bootkube.etcd_server_key}"
    peer_cert   = "${module.bootkube.etcd_peer_cert}"
    peer_key    = "${module.bootkube.etcd_peer_key}"
  }

  providers = {
    docker = "docker.sydney"
  }

  depends_on = "${module.bootkube.id}"
}

module "kubelet-master" {
  source   = "modules/kubelet"
  host_ip  = "${var.ips["dovpn"]}"
  k8s_host = "k8s.${var.root-domain}"

  assets = {
    kubeconfig   = "${module.bootkube.kubeconfig-kubelet}"
    ca_cert      = "${base64decode(module.bootkube.ca_cert)}"
    kubelet_cert = "${base64decode(module.bootkube.kubelet_cert)}"
    kubelet_key  = "${base64decode(module.bootkube.kubelet_key)}"
  }

  depends_on = "${module.bootkube-start.image}"

  providers = {
    docker = "docker.sydney"
  }
}

module "bootkube-start" {
  source    = "modules/bootkube"
  mode      = "start"
  host_ip   = "${var.ips["dovpn"]}"
  k8s_host  = "k8s.${var.root-domain}"
  asset-dir = "${path.root}/k8s"

  assets = {
    kubeconfig-kubelet = "${module.bootkube.kubeconfig-kubelet}"
    etcd_ca_cert       = "${module.bootkube.etcd_ca_cert}"
    etcd_client_cert   = "${module.bootkube.etcd_client_cert}"
    etcd_client_key    = "${module.bootkube.etcd_client_key}"
    etcd_server_cert   = "${module.bootkube.etcd_server_cert}"
    etcd_server_key    = "${module.bootkube.etcd_server_key}"
    etcd_peer_cert     = "${module.bootkube.etcd_peer_cert}"
    etcd_peer_key      = "${module.bootkube.etcd_peer_key}"
  }

  providers = {
    docker = "docker.sydney"
  }
}

module "bootkube" {
  source = "git::https://github.com/poseidon/terraform-render-bootkube.git?ref=bcbdddd8d07c99ab88b2e9ebfb662de4c104de0a"

  cluster_name          = "k8s.bb8.fun"
  api_servers           = ["10.8.0.1", "k8s.bb8.fun"]
  cluster_domain_suffix = "k8s.bb8.fun"
  etcd_servers          = ["etcd.bb8.fun"]
  asset_dir             = "./k8s"
}
