module "container" {
  source = "../container"
  image  = "captn3m0/etcd:v3.3.11"
  name   = "etcd"

  web = {
    expose = false
    host   = ""
  }

  volumes = [
    {
      host_path      = "${var.data_dir}"
      container_path = "/etcd-data"
    },
    {
      host_path      = "${var.bootkube_asset_dir}/tls/etcd-client.crt"
      container_path = "/etc/etcd-client.crt"
    },
    {
      host_path      = "${var.bootkube_asset_dir}/tls/etcd-client.key"
      container_path = "/etc/etcd-client.key"
    },
    {
      host_path      = "${var.bootkube_asset_dir}/tls/etcd-client-ca.crt"
      container_path = "/etc/etcd-client-ca.crt"
    },
    {
      host_path      = "${var.bootkube_asset_dir}/tls/etcd"
      container_path = "/etc/ssl/certs/etcd"
    },
  ]

  ports = [
    {
      internal = 2379
      external = 2379
      ip       = "${var.host_ip}"
    },
    {
      internal = 2380
      external = 2380
      ip       = "${var.host_ip}"
    },
  ]

  command = [
    "/usr/local/bin/etcd",
    "--data-dir=/etcd-data",
    "--name=${var.node_name}",
    "--advertise-client-urls=https://${var.host_ip}:2379",
    "--initial-advertise-peer-urls=https://${var.host_ip}:2380",
    "--initial-cluster=${var.node_name}=https://${var.host_ip}:2380",
    "--listen-client-urls=https://0.0.0.0:2379",
    "--listen-peer-urls=https://0.0.0.0:2380",
    "--trusted-ca-file=/etc/ssl/certs/etcd/server-ca.crt",
    "--cert-file=/etc/ssl/certs/etcd/server.crt",
    "--key-file=/etc/ssl/certs/etcd/server.key",
    "--client-cert-auth=true",
    "--peer-trusted-ca-file=/etc/ssl/certs/etcd/peer-ca.crt",
    "--peer-cert-file=/etc/ssl/certs/etcd/peer.crt",
    "--peer-key-file=/etc/ssl/certs/etcd/peer.key",
  ]
}
