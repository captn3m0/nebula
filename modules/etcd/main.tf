module "container" {
  source = "../container"
  image  = "captn3m0/etcd:v3.3.11"
  name   = "etcd"

  web = {
    expose = false
    host   = ""
  }

  networks = ["${docker_network.etcd.id}"]

  volumes = [
    {
      host_path      = "${var.data_dir}"
      container_path = "/etcd-data"
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
}

resource "docker_network" "etcd" {
  name   = "etcd"
  driver = "bridge"

  ipam_config {
    subnet  = "10.10.10.0/25"
    gateway = "10.10.10.1"
  }
}
