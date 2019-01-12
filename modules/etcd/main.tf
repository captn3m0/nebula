module "container" {
  source = "../container"
  image  = "captn3m0/etcd:v3.3.11"
  name   = "etcd"

  web = {
    expose = false
    host   = ""
  }

  networks = []

  volumes = [
    {
      host_path      = "/usr/share/ca-certificates/"
      container_path = "/etc/ssl/certs"
    },
    {
      host_path      = "${var.data_dir}"
      container_path = "/etcd-data"
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
    "--advertise-client-urls=http://${var.host_ip}:2379",
    "--initial-advertise-peer-urls=http://${var.host_ip}:2380",
    "--initial-cluster=${var.node_name}=http://${var.host_ip}:2380",
  ]

  # "--listen-client-urls=http://0.0.0.0:2379",
  # "--listen-peer-urls=http://0.0.0.0:2380",
}
