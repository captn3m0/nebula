resource "docker_container" "etcd" {
  name  = "etcd"
  image = "${docker_image.image.latest}"

  volumes {
    host_path      = "${var.data_dir}"
    container_path = "/etcd-data"
  }

  ports {
    internal = 2379
    external = 2379
    ip       = "${var.host_bind_ip}"
  }

  ports {
    internal = 2380
    external = 2380
    ip       = "${var.host_bind_ip}"
  }

  upload {
    content = "${var.pki["ca_cert"]}"
    file    = "/etc/ssl/ca_cert.pem"
  }

  upload {
    content = "${var.pki["server_cert"]}"
    file    = "/etc/ssl/server_cert.pem"
  }

  upload {
    content = "${var.pki["server_key"]}"
    file    = "/etc/ssl/server_key.pem"
  }

  upload {
    content = "${var.pki["peer_cert"]}"
    file    = "/etc/ssl/peer_cert.pem"
  }

  upload {
    content = "${var.pki["peer_key"]}"
    file    = "/etc/ssl/peer_key.pem"
  }

  env = [
    "ETCD_NAME=${var.node_name}",
    "ETCD_DATA_DIR=/etcd-data",
    "ETCD_ADVERTISE_CLIENT_URLS=https://${var.domain}:2379",
    "ETCD_INITIAL_ADVERTISE_PEER_URLS=https://${var.domain}:2380",
    "ETCD_LISTEN_CLIENT_URLS=https://0.0.0.0:2379",
    "ETCD_LISTEN_PEER_URLS=https://0.0.0.0:2380",
    "ETCD_LISTEN_METRICS_URLS=http://0.0.0.0:2381",
    "ETCD_CLIENT_CERT_AUTH=true",
    "ETCD_INITIAL_CLUSTER=${var.node_name}=https://${var.domain}:2380",
    "ETCD_STRICT_RECONFIG_CHECK=true",
    "ETCD_CERT_FILE=/etc/ssl/server_cert.pem",
    "ETCD_KEY_FILE=/etc/ssl/server_key.pem",
    "ETCD_TRUSTED_CA_FILE=/etc/ssl/ca_cert.pem",
    "ETCD_PEER_TRUSTED_CA_FILE=/etc/ssl/ca_cert.pem",
    "ETCD_PEER_CERT_FILE=/etc/ssl/peer_cert.pem",
    "ETCD_PEER_KEY_FILE=/etc/ssl/peer_key.pem",
    "ETCD_PEER_CLIENT_CERT_AUTH=true",
  ]

  command = [
    "/usr/local/bin/etcd",
  ]
}

data "docker_registry_image" "image" {
  name = "quay.io/coreos/etcd:v${var.version}"
}

resource "docker_image" "image" {
  name          = "${data.docker_registry_image.image.name}"
  pull_triggers = ["${data.docker_registry_image.image.sha256_digest}"]
}
